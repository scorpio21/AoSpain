using System;
using System.IO;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Drawing;
using System.Diagnostics;
using System.Text;

namespace AO_GrhConverter
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            ApplicationConfiguration.Initialize();
            Application.Run(new MainForm());
        }
    }

    public class MainForm : Form
    {
        private TextBox logBox;
        private Button convertIndBtn, convertMapsBtn, selectFolderBtn, viewerBtn;
        private string inputPath = "";
        private string baseOutputPath = @"E:\xampp\htdocs\AoSpain\";

        public MainForm()
        {
            this.Text = "AO Spain Editor Tools (.NET 8) - ESTÁNDAR ANSI";
            this.Width = 800; this.Height = 600;
            this.StartPosition = FormStartPosition.CenterScreen;

            Panel topPanel = new Panel() { Dock = DockStyle.Top, Height = 120, BackColor = Color.FromArgb(30, 30, 30) };
            selectFolderBtn = CreateBtn("1. SELECCIONAR ORIGEN", 20, 10, 250, Color.LightBlue);
            selectFolderBtn.Click += (s, e) => {
                using var fbd = new FolderBrowserDialog();
                if (fbd.ShowDialog() == DialogResult.OK) {
                    inputPath = fbd.SelectedPath;
                    Log("Origen: " + inputPath);
                    convertIndBtn.Enabled = convertMapsBtn.Enabled = true;
                }
            };

            convertIndBtn = CreateBtn("CONVERTIR ÍNDICES (32-bit)", 20, 60, 250, Color.LightBlue, false);
            convertIndBtn.Click += (s, e) => IniciarConversion(true);
            convertMapsBtn = CreateBtn("CONVERTIR MAPAS (32-bit)", 280, 60, 250, Color.LightGreen, false);
            convertMapsBtn.Click += (s, e) => IniciarConversion(false);
            viewerBtn = CreateBtn("VISUALIZADOR / EXPORTADOR .DAT", 540, 10, 230, Color.Gold);
            viewerBtn.Click += (s, e) => new ViewerForm().Show();

            topPanel.Controls.AddRange(new Control[] { selectFolderBtn, convertIndBtn, convertMapsBtn, viewerBtn });
            logBox = new TextBox() { Multiline = true, Dock = DockStyle.Fill, ReadOnly = true, BackColor = Color.Black, ForeColor = Color.Lime, Font = new Font("Consolas", 10), ScrollBars = ScrollBars.Vertical };
            this.Controls.Add(logBox); this.Controls.Add(topPanel);
        }

        private Button CreateBtn(string txt, int x, int y, int w, Color? c = null, bool enabled = true) {
            var b = new Button() { Text = txt, Left = x, Top = y, Width = w, Height = 40, Enabled = enabled };
            if (c.HasValue) b.BackColor = c.Value; return b;
        }

        private void Log(string t) => logBox.AppendText($"[{DateTime.Now:HH:mm:ss}] {t}{Environment.NewLine}");

        private async void IniciarConversion(bool ind) {
            string outFolder = Path.Combine(baseOutputPath, ind ? "Init_Convertido" : "Map_Convertidos");
            if (!Directory.Exists(outFolder)) Directory.CreateDirectory(outFolder);
            await System.Threading.Tasks.Task.Run(() => {
                try {
                    if (ind) {
                        ProcesarIndice("Graficos.ind", outFolder, "grh");
                        ProcesarIndice("Cabezas.ind", outFolder, "generic", 4);
                        ProcesarIndice("Cascos.ind", outFolder, "generic", 4);
                        ProcesarIndice("Personajes.ind", outFolder, "generic", 4, 4);
                        ProcesarIndice("Fxs.ind", outFolder, "generic", 1, 4);
                    } else ProcesarMapas(outFolder);
                    Log("Proceso terminado. Abriendo " + outFolder);
                    Process.Start("explorer.exe", outFolder);
                } catch (Exception ex) { Log("ERROR: " + ex.Message); }
            });
        }

        private void ProcesarIndice(string file, string outF, string type, int frames = 0, int extra = 0) {
            string pIn = Path.Combine(inputPath, file);
            if (!File.Exists(pIn)) return;
            Log("Convirtiendo " + file + "...");
            using var r = new BinaryReader(File.OpenRead(pIn));
            using var w = new BinaryWriter(File.Create(Path.Combine(outF, file)));
            w.Write(r.ReadBytes(263)); // Header
            if (type == "grh") {
                w.Write(r.ReadBytes(10)); // 5 Integers
                while (r.BaseStream.Position < r.BaseStream.Length - 1) {
                    short id = r.ReadInt16(); w.Write((int)id);
                    if (id <= 0) break;
                    short nf = r.ReadInt16(); w.Write(nf);
                    if (nf > 1) { for (int i = 0; i < nf; i++) w.Write((int)r.ReadInt16()); w.Write(r.ReadInt16()); }
                    else w.Write(r.ReadBytes(10));
                }
            } else {
                if (r.BaseStream.Position >= r.BaseStream.Length) return;
                short count = r.ReadInt16(); w.Write(count);
                for (int i = 0; i < count; i++) {
                    for (int f = 0; f < frames; f++) w.Write((int)r.ReadInt16());
                    if (extra > 0) w.Write(r.ReadBytes(extra));
                }
            }
        }

        private void ProcesarMapas(string outF) {
            foreach (var m in Directory.GetFiles(inputPath, "*.map")) {
                using var r = new BinaryReader(File.OpenRead(m));
                using var w = new BinaryWriter(File.Create(Path.Combine(outF, Path.GetFileName(m))));
                w.Write(r.ReadInt16()); w.Write(r.ReadBytes(263)); w.Write(r.ReadBytes(8));
                for (int i = 0; i < 10000; i++) {
                    if (r.BaseStream.Position >= r.BaseStream.Length) break;
                    w.Write(r.ReadByte());
                    for (int f = 0; f < 4; f++) w.Write((int)r.ReadInt16());
                    w.Write(r.ReadInt16()); w.Write(r.ReadInt16());
                }
            }
        }
    }

    public class ViewerForm : Form {
        private DataGridView grid;
        private Button loadBtn, exportBtn;
        private List<string> datLines = new();

        public ViewerForm() {
            this.Text = "Visualizador / Exporter (Exact Format ANSI)";
            this.Size = new Size(1100, 750);
            this.StartPosition = FormStartPosition.CenterParent;
            Panel p = new Panel() { Dock = DockStyle.Top, Height = 50 };
            loadBtn = new Button() { Text = "ABRIR .IND (Cualquier Bit)", Left = 10, Top = 10, Height = 30, Width = 240 };
            loadBtn.Click += (s, e) => AbrirInd();
            exportBtn = new Button() { Text = "EXPORTAR A .DAT (ANSI)", Left = 250, Top = 10, Height = 30, Width = 250, Enabled = false };
            exportBtn.Click += (s, e) => ExportarDat();
            p.Controls.AddRange(new Control[] { loadBtn, exportBtn });
            grid = new DataGridView() { Dock = DockStyle.Fill, ReadOnly = true, AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill };
            this.Controls.Add(grid); this.Controls.Add(p);
        }

        private void AbrirInd() {
            using OpenFileDialog ofd = new OpenFileDialog() { Filter = "Archivos IND|*.ind" };
            if (ofd.ShowDialog() != DialogResult.OK) return;
            datLines.Clear(); grid.Columns.Clear(); grid.Rows.Clear();
            if (ofd.FileName.EndsWith("Graficos.ind")) CargarGraficos(ofd.FileName);
            else MessageBox.Show("Solo se soporta Graficos.ind para visualización.");
            exportBtn.Enabled = datLines.Count > 0;
        }

        private void CargarGraficos(string path) {
            grid.Columns.Add("ID", "Grh"); grid.Columns.Add("Frames", "Frames"); grid.Columns.Add("Data", "Datos");
            using var r = new BinaryReader(File.OpenRead(path));
            r.ReadBytes(263); r.ReadBytes(10); 

            // Detección automática de bits: leemos el primer ID
            long pos = r.BaseStream.Position;
            int firstId32 = r.ReadInt32();
            r.BaseStream.Position = pos;
            short firstId16 = r.ReadInt16();
            
            bool is32bit = (firstId16 == 1 && firstId32 != 1) ? false : (firstId32 == 1);
            r.BaseStream.Position = pos;

            while (r.BaseStream.Position < r.BaseStream.Length - (is32bit ? 3 : 1)) {
                try {
                    int id = is32bit ? r.ReadInt32() : r.ReadInt16();
                    if (id <= 0) break;
                    short nf = r.ReadInt16();
                    
                    string line = $"Grh{id}=";
                    if (nf > 1) {
                        line += nf;
                        for (int i = 0; i < nf; i++) line += "-" + (is32bit ? r.ReadInt32() : r.ReadInt16());
                        line += "-" + r.ReadInt16(); // Speed
                    } else {
                        line += "1";
                        for (int i = 0; i < 5; i++) line += "-" + r.ReadInt16(); // FileNum, sX, sY, W, H
                        line += "-."; // Punto final del formato TempIND2
                    }
                    datLines.Add(line);
                    grid.Rows.Add(id, nf, line.Split('=')[1]);
                } catch { break; }
            }
        }

        private void ExportarDat() {
            using SaveFileDialog sfd = new SaveFileDialog() { Filter = "Archivo DAT|*.dat", FileName = "Graficos.dat" };
            if (sfd.ShowDialog() == DialogResult.OK) {
                // Forzamos codificación ANSI (Windows-1252) y saltos de línea CRLF
                Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
                using (StreamWriter sw = new StreamWriter(sfd.FileName, false, Encoding.GetEncoding(1252))) {
                    foreach (string line in datLines) {
                        sw.Write(line + "\r\n");
                    }
                }
                MessageBox.Show("Exportado correctamente con saltos de línea CRLF y codificación ANSI.");
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace ThumbGenerator
{
    public partial class Form1 : Form
    {
        string[] availabeleExtList = new string[] { "jpg", "jpeg", "png" };
        int w, h;
        int count = 0;
        public Form1()
        {
            InitializeComponent();

            w = int.Parse(tbThumbWidth.Text.Trim());
            h = int.Parse(tbThumbHeight.Text.Trim());
        }

        private void btnBrowse_Click(object sender, EventArgs e)
        {
            if (folderBrowserDialog1.ShowDialog() != DialogResult.OK)
                return;

            textBox1.Text = folderBrowserDialog1.SelectedPath;
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            if (textBox1.Text.Trim().Length == 0)
                return;

            if (!System.IO.Directory.Exists(textBox1.Text.Trim()))
            {
                MessageBox.Show("Selected path doesn't exist!");
                return;
            }

            Generate();
        }

        void Generate()
        {
            System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(textBox1.Text.Trim());
            System.IO.FileInfo[] files = di.GetFiles();
            if (files == null || files.Length == 0)
            {
                MessageBox.Show("There is not any photos find!");
                return;
            }

            errorList.Clear();
            count = 0;

            System.Text.StringBuilder SQL = new StringBuilder();

            foreach (System.IO.FileInfo file in files)
            {
                //if (file.FullName.ToLower().EndsWith(
                if (!checkFileType(file))
                    continue;
                if (file.FullName.IndexOf("thumb") > -1)
                {
                    continue;
                }
                processFile(file.FullName, SQL);
            }

            tbGeneratedSQL.Text = SQL.ToString();
            MessageBox.Show(string.Format("There are {0} thumbnails generated!", count));
            if (errorList.Count > 0)
            {
                MessageBox.Show("There are some errors happened!");
                foreach (string error in errorList)
                {
                    MessageBox.Show(error);
                }
            }
        }

        #region checkFileType

        bool checkFileType(System.IO.FileInfo file)
        {
            foreach (string extName in availabeleExtList)
            {
                if (file.FullName.ToLower().EndsWith(extName))
                    return true;
            }

            return false;
        }

        #endregion

        List<string> errorList = new List<string>();
        void processFile(string fileName, StringBuilder SQL)
        {
            try
            {

                Image sourceImg = Image.FromFile(fileName);
                //int width = sourceImg.Width;
                //int height = sourceImg.Height;

                //if (width >= height)
                //{
                //    width = this.w;
                //    height = 50 * height 
                //}
                string thumbFileName = string.Format("{0}_thumb{1}",
                    fileName.Substring(0, fileName.LastIndexOf(".")),
                    fileName.Substring(fileName.LastIndexOf(".")));

                if (System.IO.File.Exists(thumbFileName))
                {
                    System.IO.File.Delete(thumbFileName);

                }

                Image thumb = sourceImg.GetThumbnailImage(this.w, this.h, () => { return false; }, IntPtr.Zero);
                thumb.Save(thumbFileName);

                //MessageBox.Show(thumbFileName);
                SQL.AppendFormat("INSERT INTO [TPhotos] ([ThumbName],[PhotoName],[GalleryId]) VALUES ( '{0}','{1}',{2} )\r\n",
                    thumbFileName.Substring(thumbFileName.LastIndexOf("\\") + 1),
                    fileName.Substring(fileName.LastIndexOf("\\") + 1),
                    tbGalleryId.Text);

                thumb.Dispose();
                sourceImg.Dispose();
                GC.Collect();
                ++count;
            }
            catch (System.Exception ex)
            {
                errorList.Add(ex.Message);
            }
        }


        public bool ThumbnailCallback()
        {
            return false;
        }
        public void Example_GetThumb(PaintEventArgs e)
        {
            Image.GetThumbnailImageAbort myCallback = new Image.GetThumbnailImageAbort(ThumbnailCallback);
            Bitmap myBitmap = new Bitmap("Climber.jpg");
            Image myThumbnail = myBitmap.GetThumbnailImage(40, 40, myCallback, IntPtr.Zero);

            e.Graphics.DrawImage(myThumbnail, 150, 75);
        }

        private void btnGenerateSizeSql_Click(object sender, EventArgs e)
        {
            //if ( MessageBox.Show("Start","Warning",  MessageBoxButtons.YesNo)
            if (!Directory.Exists(textBox1.Text.Trim()))
            {
                MessageBox.Show("No folder found!");
                return;
            }

            DirectoryInfo di = new DirectoryInfo(textBox1.Text.Trim());
            FileInfo[] files = di.GetFiles();

            StringBuilder builder = new StringBuilder();
            foreach (FileInfo file in files)
            {
                if (file.FullName.ToLower().IndexOf("_thumb.") > -1)
                {
                    continue;
                }
                if (checkFileType(file))
                {
                    continue;
                }

                //builder.AppendFormat("UPDATE [TPhotos]
            }
        }
    }
}

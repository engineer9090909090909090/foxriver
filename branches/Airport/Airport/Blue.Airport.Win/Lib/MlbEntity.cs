using System;
using System.Collections.Generic;
using System.Text;

namespace Blue.Airport.Win.Lib
{
    public class MlbEntity
    {
        public int Id { get; set; }
        public string ticsellagt { get; set; }
    }

    public enum DataBaseType
    {
        MLB = 64,
        FLR = 65
    }
}

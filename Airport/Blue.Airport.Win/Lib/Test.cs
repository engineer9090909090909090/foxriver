using System;
using System.Collections.Generic;
using System.Text;

namespace Blue.Airport.Win
{
    public class Test
    {
        static public List<TestEntity> GetTestData(ref int total , int currentPage, int pageSize)
        {
            total = 1000012;

            List<TestEntity> list = new List<TestEntity>();
            for (int i = 0; i < pageSize; ++i)
            {
                TestEntity te = new TestEntity() { Id = i, Birthday = new DateTime(1977, 1, 1), Name = string.Format("Name {0}", i) };
                list.Add(te);
            }

            return list;
        }
    }

    public class TestEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime Birthday { get; set; }
    }
}

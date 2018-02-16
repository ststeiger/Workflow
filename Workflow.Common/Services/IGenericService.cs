using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Workflow.Common.Services
{
    public interface IGenericService<T> : IDisposable where T : class
    {
        //Query Methods
        T FindById(int id);

        void Add(T entity);
        void Update(T entity);
        void Delete(T entity);
    }
}

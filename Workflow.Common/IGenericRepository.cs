using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace Workflow.Common
{
    public interface IGenericRepository<T> : IDisposable where T : class
    {
        IEnumerable<T> Get(
            Expression<Func<T, bool>> filter = null,
            Func<IQueryable<T>, IOrderedQueryable<T>> orderBy = null,
            string includeProperties = "");

        //Query Methods
        T FindById(int id);

        //Insert/Update/Delete
        void Insert(T entity);
        void Update(T entity);
        void Delete(T entity);

        //Persistence
        void Save();
    }
}

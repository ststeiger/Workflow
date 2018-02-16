using System;
using Workflow.Common;
using Workflow.Common.Services;

namespace Workflow.Services.DataService
{
    public class GenericService<T> : IGenericService<T> where T : class
    {
        protected IGenericRepository<T> _repository;
        
        public GenericService(IGenericRepository<T> repository)
        {
            _repository = repository;
        }

        public T FindById(int id)
        {
            return _repository.FindById(id);
        }

        public void Add(T entity)
        {
            _repository.Insert(entity);
            _repository.Save();
        }

        public void Update(T entity)
        {
            _repository.Update(entity);
            _repository.Save();
        }

        public void Delete(T entity)
        {
            _repository.Delete(entity);
            _repository.Save();
        }

        #region IDisposable Support
        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    _repository.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion
    }
}

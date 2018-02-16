using System.Collections.Generic;
using System.Linq;
using Workflow.Common;
using Workflow.Common.Models;
using Workflow.Common.Services;

namespace Workflow.Services.DataService
{
    public class ProcessService : GenericService<Process>, IProcessService
    {
        public ProcessService(IGenericRepository<Process> repository) : base(repository) { }

        public IEnumerable<Process> GetAll()
        {
            return _repository.Get().AsEnumerable<Process>();
        }
    }
}

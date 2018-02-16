using System.Collections.Generic;
using Workflow.Common.Models;

namespace Workflow.Common.Services
{
    public interface IRequestService : IGenericService<Request>
    {
        IEnumerable<Request> GetAll();
    }
}

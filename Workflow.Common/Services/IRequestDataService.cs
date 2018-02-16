using System.Collections.Generic;
using Workflow.Common.Models;

namespace Workflow.Common.Services
{
    public interface IRequestDataService : IGenericService<RequestData>
    {
        IEnumerable<RequestData> GetAll();
    }
}

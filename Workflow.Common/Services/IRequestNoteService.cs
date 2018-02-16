using System.Collections.Generic;
using Workflow.Common.Models;

namespace Workflow.Common.Services
{
    public interface IRequestNoteService : IGenericService<RequestNote>
    {
        IEnumerable<RequestNote> GetAll();
    }
}

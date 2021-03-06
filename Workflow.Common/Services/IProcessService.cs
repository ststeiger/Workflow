﻿using System.Collections.Generic;
using Workflow.Common.Models;

namespace Workflow.Common.Services
{
    public interface IProcessService : IGenericService<Process>
    {
        IEnumerable<Process> GetAll();
    }
}

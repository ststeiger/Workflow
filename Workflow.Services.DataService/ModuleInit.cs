using System.ComponentModel.Composition;
using Workflow.Common;
using Workflow.Common.Models;
using Workflow.Common.Services;

namespace Workflow.Services.DataService
{
    [Export(typeof(IModule))]
    public class ModuleInit : IModule
    {
        public void Initialize(IModuleRegistrar registrar)
        {
            registrar.RegisterType<IGenericService<Process>, GenericService<Process>>();
            registrar.RegisterType<IProcessService, ProcessService>();
        }
    }
}


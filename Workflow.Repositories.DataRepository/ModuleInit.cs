using System.ComponentModel.Composition;
using Workflow.Common;
using Workflow.Common.Models;

namespace Workflow.Repositories.DataRepository
{
    [Export(typeof(IModule))]
    public class ModuleInit : IModule
    {
        public void Initialize(IModuleRegistrar registrar)
        {
            registrar.RegisterType<IGenericRepository<Process>, GenericRepository<Process>>();
        }
    }
}

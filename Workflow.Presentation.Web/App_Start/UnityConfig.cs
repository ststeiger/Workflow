using Microsoft.Practices.Unity;
using System.Web.Mvc;
using Unity.Mvc5;
using Workflow.Common.Models;
using Workflow.Presentation.Web.Infrastructure;
using Workflow.Repositories.DataRepository;

namespace Workflow.Presentation.Web
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
            var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            // e.g. container.RegisterType<ITestService, TestService>();


            //container.RegisterType<Common.IGenericRepository<Process>
            //    , GenericRepository<Process>>();

            //container.RegisterType<Common.Services.IProcessService, 
            //    Services.DataService.ProcessService>();
            

            //container.RegisterTypes(
            //    AllClasses.FromLoadedAssemblies(),
            //    WithMappings.FromMatchingInterface,
            //    WithName.Default);

            ModuleLoader.LoadContainer(container, ".\\bin", "W*.dll");

            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}
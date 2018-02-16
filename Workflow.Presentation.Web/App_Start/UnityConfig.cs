using Microsoft.Practices.Unity;
using System.Web.Mvc;
using Unity.Mvc5;
using Workflow.Presentation.Web.Infrastructure;

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

            //container.RegisterTypes(
            //    AllClasses.FromLoadedAssemblies(),
            //    WithMappings.FromMatchingInterface,
            //    WithName.Default);

            ModuleLoader.LoadContainer(container, ".\\bin", "W*.dll");

            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}
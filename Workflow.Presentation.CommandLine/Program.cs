using System;
using Microsoft.Practices.Unity;

using Workflow.Common.Models;

namespace Workflow.Presentation.CommandLine
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var container = new UnityContainer())
            {
                ContainerBootstrapper.RegisterTypes(container);

                container.Resolve<IProcess>().Initialize();
                container.Resolve<ISurveyAnswerStore>().Initialize();
                container.Resolve<ITenantStore>().Initialize();

                Console.WriteLine("Done");
                Console.ReadLine();
            }
        }
    }
}

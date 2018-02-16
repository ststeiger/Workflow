using Microsoft.Practices.Unity;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Workflow.Presentation.CommandLine
{
    public class ContainerBootstrapper
    {
        public static void RegisterTypes(IUnityContainer container)
        {
            Trace.WriteLine(string.Format("Called RegisterTypes in ContainerBootstrapper"), "UNITY");

          
        }
    }
}

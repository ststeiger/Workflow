using System.Collections.Generic;

namespace Workflow.Common.Models
{
    public class StateType
    {
        public int? StateTypeId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<State> States { get; set; }
    }
}

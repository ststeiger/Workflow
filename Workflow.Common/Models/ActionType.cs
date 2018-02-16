using System.Collections.Generic;

namespace Workflow.Common.Models
{
    public class ActionType
    {
        public int? ActionTypeId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Action> Actions { get; set; }
    }
}

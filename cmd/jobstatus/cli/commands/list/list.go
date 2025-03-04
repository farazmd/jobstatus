package list

import (
	"github.com/spf13/cobra"
)

// listCmd represents the list command
var ListCmd = &cobra.Command{
	Use:   "list",
	Short: "Lists all applications",
	Long:  `Lists all applications stored. You can also filter based on current status of the application.`,
	Run: func(cmd *cobra.Command, args []string) {
		cmd.Help()
	},
}

func init() {
	var filter string
	ListCmd.PersistentFlags().StringVarP(&filter, "filter", "f", "", "A status of either Applied, Interviewing or Rejected")
}

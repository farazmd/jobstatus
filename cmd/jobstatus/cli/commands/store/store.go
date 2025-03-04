package store

import (
	"github.com/spf13/cobra"
)

// storeCmd represents the store command
var StoreCmd = &cobra.Command{
	Use:   "store",
	Short: "Stores an application.",
	Long:  `Stores an application into the specified storage backend.`,
	Run: func(cmd *cobra.Command, args []string) {
		cmd.Help()
	},
}

func init() {

}

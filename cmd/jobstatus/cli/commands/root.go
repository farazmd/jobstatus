package commands

import (
	"fmt"
	"os"

	"github.com/farazmd/jobstatus/cmd/jobstatus/cli/commands/get"
	"github.com/farazmd/jobstatus/cmd/jobstatus/cli/commands/list"
	"github.com/farazmd/jobstatus/cmd/jobstatus/cli/commands/store"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var cfgFile string

// rootCmd represents the base command for job status
var rootCmd = &cobra.Command{
	Use:   "jobstatus",
	Short: "Job application tracker",
	Long:  `A CLI tool to parse, store job applications and track status`,
	Run: func(cmd *cobra.Command, args []string) {
		cmd.Help()
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	cobra.OnInitialize(initConfig)
	rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.jobstatus.yaml)")
	addCommands(rootCmd)
}

// initConfig reads in config file and ENV variables if set.
func initConfig() {
	if cfgFile != "" {
		// Use config file from the flag.
		viper.SetConfigFile(cfgFile)
	} else {
		// Find home directory.
		home, err := os.UserHomeDir()
		cobra.CheckErr(err)

		// Search config in home directory with name ".jobstatus" (without extension).
		viper.AddConfigPath(home)
		viper.SetConfigType("yaml")
		viper.SetConfigName(".jobstatus")
	}

	viper.AutomaticEnv() // read in environment variables that match

	// If a config file is found, read it in.
	if err := viper.ReadInConfig(); err == nil {
		fmt.Fprintln(os.Stderr, "Using config file:", viper.ConfigFileUsed())
	}
}

// addCommands initalizes and adds all commands/subcommands to rootCmd
func addCommands(root *cobra.Command) {
	root.AddCommand(get.GetCmd)
	root.AddCommand(list.ListCmd)
	root.AddCommand(store.StoreCmd)
}

package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"code.google.com/p/gcfg"
)

type Config struct {
	Service struct {
		Port int
	}
}

func ConfigFromFile(configFile string) (Config, error) {
	var Cfg Config
	if _, err := os.Stat(configFile); err != nil {
		return Cfg, err
	}

	err := gcfg.ReadFileInto(&Cfg, configFile)

	return Cfg, err
}

var gitversion string

func main() {
	file := flag.String("config", "config/development.ini", "Config file location")
	version := flag.Bool("gitversion", false, "Print godex git version")

	flag.Parse()

	if *version {
		fmt.Println(gitversion)
		os.Exit(0)
	}

	config, err := ConfigFromFile(*file)
	if err != nil {
		log.Fatal(err.Error())
		os.Exit(1)
	}
	log.Printf("Binding to Port %d\n", config.Service.Port)
}

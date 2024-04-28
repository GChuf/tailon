// +build windows

package cmd

import (
	"fmt"
	"os/exec"
)

func terminatePID(pid int) error {
	// Use taskkill command to terminate the process
	cmd := exec.Command("taskkill", "/F", "/T", "/PID", fmt.Sprint(pid))
	err := cmd.Run()
	if err != nil {
		return err
	}
	return nil
}

func setGroupID(*exec.Cmd) {
}
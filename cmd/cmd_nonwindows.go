// +build !windows

package cmd

import (
	"syscall"
	"os/exec"
)

func terminatePID(pid int) error {
	// Signal the process group (-pid), not just the process, so that the process
	// and all its children are signaled. Else, child procs can keep running and
	// keep the stdout/stderr fd open and cause cmd.Wait to hang.
	return syscall.Kill(-pid, syscall.SIGTERM)

}

func setGroupID(cmd *exec.Cmd) {
    cmd.SysProcAttr = &syscall.SysProcAttr{Setpgid: true}
}

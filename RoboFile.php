<?php

/**
 * Console commands configuration for Robo task runner.
 *
 * @see http://robo.li/
 */
class RoboFile extends \Robo\Tasks
{
    /**
     * Provision beetbox container.
     *
     * @param string $image Base docker image
     * @param string $name Container/Image name
     * @return \Robo\Result
     */
    public function provision($image = 'ubuntu:14.04', $name = 'beet_test')
    {
        // Create build container.
        $build = $this->taskDockerRun($image)
            ->name($name)
            ->env('INSTALL_PACKER', 'true')
            ->exec('/beetbox/provisioning/beetbox.sh')
            ->volume(__DIR__ . '/', '/beetbox/')
            ->volume(__DIR__, '/var/beetbox')
            ->interactive()
            ->run();

        if ($build->wasSuccessful()) {
            // Commit build container to an image.
            $this->taskDockerCommit($build['cid'])
                ->name($name)
                ->run();
        }

        // Remove build container.
        $this->taskDockerRemove($name)
            ->printed(FALSE)
            ->run();

        return $build;
    }

}

<?php

/**
 * @file
 * Contains \Beet|Box\Tests\PluginTest.
 */

namespace Beet\Box\Tests;

use Composer\Util\Filesystem;

/**
 * Tests composer plugin functionality.
 */
class PluginTest extends \PHPUnit_Framework_TestCase {

    /**
     * @var \Composer\Util\Filesystem
     */
    protected $fs;

    /**
     * @var string
     */
    protected $tmpDir;

    /**
     * @var string
     */
    protected $rootDir;

    /**
     * SetUp test
     */
    public function setUp() {
        $this->rootDir = realpath(realpath(__DIR__ . '/..'));

        // Prepare temp directory.
        $this->fs = new Filesystem();
        $this->tmpDir = realpath(sys_get_temp_dir()) . DIRECTORY_SEPARATOR . 'beetbox';
        $this->ensureDirectoryExistsAndClear($this->tmpDir);

        $this->writeComposerJSON();

        chdir($this->tmpDir);
    }

    /**
     * tearDown
     *
     * @return void
     */
    public function tearDown()
    {
        $this->fs->removeDirectory($this->tmpDir);
    }

    /**
     * Tests a composer install and update to ensure Vagrantfile is added.
     */
    public function testComposerInstallAndUpdate() {
        $vagrantFile = $this->tmpDir . DIRECTORY_SEPARATOR . 'Vagrantfile';
        $this->assertFileNotExists($vagrantFile, 'Vagrantfile should not be exist.');
        $this->composer('install');
        $this->assertFileExists($vagrantFile, 'Vagrantfile should be automatically installed.');
        $this->fs->remove($vagrantFile);
        $this->assertFileNotExists($vagrantFile, 'Vagrantfile should not be exist.');
        $this->composer('update');
        $this->assertFileExists($vagrantFile, 'Vagrantfile should be automatically recreated.');
    }

    /**
     * Writes the default composer json to the temp direcoty.
     */
    protected function writeComposerJSON() {
        $json = json_encode($this->composerJSONDefaults(), JSON_PRETTY_PRINT);
        // Write composer.json.
        file_put_contents($this->tmpDir . '/composer.json', $json);
    }

    /**
     * Provides the default composer.json data.
     *
     * @return array
     */
    protected function composerJSONDefaults() {
        return array(
            'repositories' => array(
                array(
                    'type' => 'path',
                    'url' => $this->rootDir,
                )
            ),
            'require' => array(
                'beet/box' => "*"
            ),
            'minimum-stability' => 'dev'
        );
    }

    /**
     * Wrapper for the composer command.
     *
     * @param string $command
     *   Composer command name, arguments and/or options
     */
    protected function composer($command) {
        chdir($this->tmpDir);
        passthru(escapeshellcmd($this->rootDir . '/vendor/bin/composer ' . $command), $exit_code);
        if ($exit_code !== 0) {
            throw new \Exception('Composer returned a non-zero exit code');
        }
    }

    /**
     * Makes sure the given directory exists and has no content.
     *
     * @param string $directory
     */
    protected function ensureDirectoryExistsAndClear($directory) {
        if (is_dir($directory)) {
            $this->fs->removeDirectory($directory);
        }
        mkdir($directory, 0777, true);
    }
}

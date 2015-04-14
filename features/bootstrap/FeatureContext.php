<?php

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends \Behat\MinkExtension\Context\MinkContext
{
    private $pages;

    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
        $definitions_path = realpath(__DIR__.'/..').'/Definitions.yaml';
        $this->pages = \Symfony\Component\Yaml\Yaml::parse($definitions_path)['Pages'];
    }

    /**
     * Opens named page
     *
     * @Given /^(?:|I )am on "(?P<name>[\w\s]+)" page$/
     * @When /^(?:|I )go to "(?P<name>[\w\s]+)" page$/
     */
    public function iAmOnNamedPage($name)
    {
        if (!array_key_exists($name, $this->pages)) {
            throw new \LogicException("Page named '{$name}' is not listed in Definitions.yaml");
        }

        $this->visitPath($this->pages[$name]);
    }

    /**
     * Checks, that current page is the named page
     *
     * @Then /^(?:|I )should be on "(?P<name>[\w\s]+)" page$/
     */
    public function assertNamedPage($name)
    {
        if (!array_key_exists($name, $this->pages)) {
            throw new \LogicException("Page named '{$name}' is not listed in Definitions.yaml");
        }

        $this->assertSession()->addressEquals($this->locatePath($this->pages[$name]));
    }
}

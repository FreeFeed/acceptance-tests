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
        $definitions = \Symfony\Component\Yaml\Yaml::parse($definitions_path);

        $this->pages = $definitions['Pages'];
        $this->elements = $definitions['Elements'];
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

    /**
     * Checks, that specified named element exists on page.
     *
     * @Then /^(?:|I )should see an? (?P<name>[^"]*)$/
     */
    public function assertNamedElementOnPage($name)
    {
        if (!array_key_exists($name, $this->elements)) {
            throw new \LogicException("Element named '{$name}' is not listed in Definitions.yaml");
        }

        $this->assertSession()->elementExists('css', $this->elements[$name]);
    }

    /**
     * Checks, that specified named element doesn't exist on page.
     *
     * @Then /^(?:|I )should not see an? (?P<name>[^"]*)$/
     */
    public function assertNamedElementNotOnPage($name)
    {
        if (!array_key_exists($name, $this->elements)) {
            throw new \LogicException("Element named '{$name}' is not listed in Definitions.yaml");
        }

        $this->assertSession()->elementNotExists('css', $this->elements[$name]);
    }
}

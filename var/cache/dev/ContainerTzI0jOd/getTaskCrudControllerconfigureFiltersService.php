<?php

namespace ContainerTzI0jOd;

use Symfony\Component\DependencyInjection\Argument\RewindableGenerator;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\DependencyInjection\Exception\RuntimeException;

/**
 * @internal This class has been auto-generated by the Symfony Dependency Injection Component.
 */
class getTaskCrudControllerconfigureFiltersService extends App_KernelDevDebugContainer
{
    /**
     * Gets the private '.service_locator.3Xb4Hur.App\Controller\Admin\TaskCrudController::configureFilters()' shared service.
     *
     * @return \Symfony\Component\DependencyInjection\ServiceLocator
     */
    public static function do($container, $lazyLoad = true)
    {
        return $container->privates['.service_locator.3Xb4Hur.App\\Controller\\Admin\\TaskCrudController::configureFilters()'] = (new \Symfony\Component\DependencyInjection\Argument\ServiceLocator($container->getService ??= $container->getService(...), [
            'filters' => ['privates', '.errored..service_locator.3Xb4Hur.EasyCorp\\Bundle\\EasyAdminBundle\\Config\\Filters', NULL, 'Cannot autowire service ".service_locator.3Xb4Hur": it references class "EasyCorp\\Bundle\\EasyAdminBundle\\Config\\Filters" but no such service exists.'],
        ], [
            'filters' => 'EasyCorp\\Bundle\\EasyAdminBundle\\Config\\Filters',
        ]))->withContext('App\\Controller\\Admin\\TaskCrudController::configureFilters()', $container);
    }
}

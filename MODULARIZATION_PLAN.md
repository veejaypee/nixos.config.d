
# Plan for Modularizing the NixOS Configuration

This document outlines a plan to streamline and modularize the NixOS configuration for the `yorishiro` host.

## 1. Analysis of the Current Configuration

The current configuration is spread across several files, with some degree of modularity already in place. However, the main `configuration.nix` for `yorishiro` is quite large and contains a lot of configuration that could be extracted into reusable modules.

- **`flake.nix`**: Defines the system's inputs and outputs, with separate configurations for `yorishiro` and `kamidana`.
- **`hosts/yorishiro/configuration.nix`**: The main configuration for `yorishiro`, containing a mix of system settings, package installations, and service configurations.
- **`hosts/yorishiro/home.nix`**: The Home Manager configuration for the `veitp` user on `yorishiro`.
- **`modules/`**: A directory containing some reusable modules, which is a good practice.

## 2. Proposed Modularization Strategy

The goal is to make the configuration more organized, reusable, and easier to manage. This will be achieved by creating a more granular module structure.

### 2.1. Create a `common` module

A new `common` module will be created to hold configuration that is shared across all hosts. This will reduce duplication and improve consistency. This module will include:

- User accounts and basic settings.
- Core packages that should be available on all systems.
- Default shell configuration.

### 2.2. Create Feature-Based Modules

The large `configuration.nix` will be broken down into smaller, feature-based modules. This will make it easier to enable or disable specific sets of features on a per-host basis. The following modules will be created:

- **`development`**: For development tools, languages, and IDEs.
- **`desktop`**: For desktop applications, window managers, and themes.
- **`services`**: For system services like Docker, Bluetooth, etc.
- **`work`**: For work-specific configurations, such as VPN settings and host entries.

### 2.3. Refactor Host-Specific Configurations

The host-specific configuration files will be refactored to import the new modules. This will make the host configurations much leaner and more focused on what is unique to that host.

## 3. Step-by-Step Implementation Plan

1.  **Create `modules/common/default.nix`**:
    - Move user accounts, time zone, locale, and other common settings to this file.
    - Define a set of common packages that should be installed on all hosts.

2.  **Create Feature Modules**:
    - **`modules/development/default.nix`**: Move development-related packages and settings here.
    - **`modules/desktop/default.nix`**: Move desktop applications and UI-related settings here.
    - **`modules/services/default.nix`**: Move system service configurations here.
    - **`modules/work/default.nix`**: Move work-specific settings here.

3.  **Create a Common Home Manager Configuration**:
    - Create a `hosts/common/home.nix` file for shared Home Manager settings.

4.  **Refactor `hosts/yorishiro/configuration.nix`**:
    - Remove the configuration that has been moved to the new modules.
    - Add imports for the new modules.

5.  **Refactor `hosts/yorishiro/home.nix`**:
    - Import the shared Home Manager configuration.

6.  **Update `flake.nix`**:
    - Modify the `nixosConfigurations` for `yorishiro` and `kamidana` to use the new `common` module.

This plan will result in a more organized and maintainable NixOS configuration.

@-moz-document domain("vault.bitwarden.com"), domain("bitwarden.com") {

:root {
    --primary-300: var(--primary) !important;
    --primary-400: var(--primary) !important;
    --primary-500: var(--primary) !important;
    --primary-600: var(--primary) !important;
    --primary-700: var(--primary) !important;
}

:root,
body {
    --text-heading: var(--on_surface) !important;
    --text-code: var(--on_primary) !important;
    --text-main: var(--on_surface) !important;
    --text-muted: var(--on_surface_variant) !important;
    --text-alt2: var(--on_surface_variant) !important;
    --text-disabled: var(--outline) !important;
    --text-info: var(--on_surface_variant) !important;
    --text-danger: var(--error) !important;
    --text-brand: var(--primary) !important;
    --text-visited: var(--tertiary) !important;
    --background-alt: var(--background) !important;
    --background-dark: var(--surface_container_lowest) !important;
    --background-disabled: var(--surface_variant) !important;
    --background-body: var(--background) !important;
    --background-modifier-hover: var(--surface_container_high) !important;
    --background-modifier-active: var(--surface_container_highest) !important;
    --background-modifier-selected: var(--surface_container_high) !important;
    --border-color: var(--outline_variant) !important;
    --border-color-dark: var(--outline) !important;
    --border-color-hover: var(--primary) !important;
    --box-shadow-color: transparent !important;
    --box-shadow-color-hover: transparent !important;
    --background-navigation: var(--surface_container) !important;
    --sidebar-background: var(--surface) !important;
    --sidebar-background-active: var(--surface_container_high) !important;
    --sidebar-border: var(--outline_variant) !important;
    --sidebar-text: var(--on_surface_variant) !important;
    --sidebar-text-active: var(--on_surface) !important;
    --card-background: var(--surface) !important;
    --card-border: var(--outline_variant) !important;
    --table-row-alternate: var(--surface_container_low) !important;
    --table-row-hover: var(--surface_container_high) !important;
    --input-background: var(--surface_container_low) !important;
    --input-border: var(--outline_variant) !important;
    --input-border-hover: var(--outline) !important;
    --input-border-focus: var(--primary) !important;
    --input-foreground: var(--on_surface) !important;
    --input-placeholder: var(--on_surface_variant) !important;
    --input-disabled-background: var(--surface_variant) !important;
    --input-disabled-border: var(--outline_variant) !important;
    --input-disabled-foreground: var(--on_surface_variant) !important;
    --popup-background: var(--surface) !important;
    --popup-border: var(--outline_variant) !important;
    --popup-foreground: var(--on_surface) !important;
    --dropdown-background: var(--surface_container) !important;
    --dropdown-border: var(--outline_variant) !important;
    --dropdown-foreground: var(--on_surface) !important;
    --toast-background: var(--surface) !important;
    --toast-border: var(--outline_variant) !important;
    --toast-foreground: var(--on_surface) !important;
    --overlay-background: rgba(0, 0, 0, 0.6) !important;
    --overlay-alt-background: var(--surface_container) !important;
    --overlay-foreground: var(--on_surface) !important;
    --overlay-border: var(--outline_variant) !important;
    --danger: var(--error) !important;
    --danger-hover: var(--error_container) !important;
    --success: var(--tertiary) !important;
    --success-hover: var(--tertiary_container) !important;
    --warning: var(--secondary) !important;
    --warning-hover: var(--secondary_container) !important;
    --info: var(--primary) !important;
    --info-hover: var(--primary_container) !important;
    --button-primary-background: var(--primary) !important;
    --button-primary-foreground: var(--on_primary) !important;
    --button-primary-hover: var(--primary_fixed_dim) !important;
    --button-primary-active: var(--primary_fixed) !important;
    --button-primary-disabled-background: var(--surface_variant) !important;
    --button-primary-disabled-foreground: var(--on_surface_variant) !important;
    --button-secondary-background: var(--surface_container) !important;
    --button-secondary-foreground: var(--on_surface) !important;
    --button-secondary-hover: var(--surface_container_high) !important;
    --button-secondary-active: var(--surface_container_highest) !important;
    --button-secondary-disabled-background: var(--surface_variant) !important;
    --button-secondary-disabled-foreground: var(--on_surface_variant) !important;
    --button-danger-background: var(--error) !important;
    --button-danger-foreground: var(--on_error) !important;
    --button-danger-hover: var(--error_container) !important;
    --button-danger-active: var(--error_container) !important;
    --button-danger-disabled-background: var(--surface_variant) !important;
    --button-danger-disabled-foreground: var(--on_surface_variant) !important;
    --scrollbar-background: transparent !important;
    --scrollbar-thumb: var(--surface_container_highest) !important;
    --accent-color: var(--primary) !important;
}

/* Extension popup — more compact rows and matching borders */
.browser-popup {
    background-color: var(--surface) !important;
    border: 1px solid var(--outline_variant) !important;
    border-radius: 12px !important;
}
}

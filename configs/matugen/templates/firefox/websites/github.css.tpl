@-moz-document domain("github.com"), domain("gist.github.com") {

:root,
[data-color-mode=auto][data-dark-theme=dark],
[data-color-mode=auto][data-light-theme=light],
[data-color-mode=dark],
[data-color-mode=light] {
    --bgColor-default: var(--background) !important;
    --bgColor-muted: var(--surface_container_low) !important;
    --bgColor-inset: var(--surface_container_lowest) !important;
    --bgColor-emphasis: var(--primary) !important;
    --bgColor-accent: var(--primary_container) !important;
    --bgColor-success: var(--tertiary_container) !important;
    --bgColor-attention: var(--secondary_container) !important;
    --bgColor-danger: var(--error_container) !important;
    --bgColor-accent-muted: var(--surface_variant) !important;
    --fgColor-default: var(--on_surface) !important;
    --fgColor-muted: var(--on_surface_variant) !important;
    --fgColor-accent: var(--primary) !important;
    --fgColor-success: var(--tertiary) !important;
    --fgColor-attention: var(--secondary) !important;
    --fgColor-danger: var(--error) !important;
    --fgColor-link: var(--primary) !important;
    --fgColor-onEmphasis: var(--on_primary) !important;
    --borderColor-default: var(--outline_variant) !important;
    --borderColor-muted: var(--outline_variant) !important;
    --borderColor-accent: var(--primary) !important;
    --borderColor-emphasis: var(--primary) !important;
    --borderColor-success: var(--tertiary) !important;
    --borderColor-attention: var(--secondary) !important;
    --borderColor-danger: var(--error) !important;
    --button-bgColor-rest: var(--surface_container) !important;
    --button-bgColor-hover: var(--surface_container_high) !important;
    --button-bgColor-active: var(--surface_container_highest) !important;
    --button-fgColor-rest: var(--on_surface) !important;
    --button-borderColor-rest: var(--outline_variant) !important;
    --button-primary-bgColor-rest: var(--primary) !important;
    --button-primary-bgColor-hover: var(--primary_fixed_dim) !important;
    --button-primary-fgColor-rest: var(--on_primary) !important;
    --button-primary-borderColor-rest: transparent !important;
    --button-danger-bgColor-rest: var(--error) !important;
    --button-danger-bgColor-hover: var(--error_container) !important;
    --button-danger-fgColor-rest: var(--on_error) !important;
    --button-outline-bgColor-rest: transparent !important;
    --button-outline-bgColor-hover: var(--surface_container) !important;
    --button-outline-fgColor-rest: var(--primary) !important;
    --button-outline-borderColor-rest: var(--outline_variant) !important;
    --overlay-bgColor: var(--surface) !important;
    --overlay-borderColor: var(--outline_variant) !important;
    --header-bgColor: var(--surface_container) !important;
    --header-fgColor: var(--on_surface) !important;
    --header-logoColor: var(--primary) !important;
    --sideNav-bgColor: var(--surface) !important;
    --sideNav-borderColor: var(--outline_variant) !important;
    --checkbox-bgColor-rest: var(--surface_container_low) !important;
    --checkbox-borderColor-rest: var(--outline_variant) !important;
    --input-bgColor: var(--surface_container_low) !important;
    --input-borderColor: var(--outline_variant) !important;
    --input-focus-borderColor: var(--primary) !important;
    --control-borderColor-emphasis: var(--outline) !important;
    --control-borderColor-rest: var(--outline_variant) !important;
    --control-borderColor-hover: var(--outline) !important;
    --treeNode-fgColor-hover: var(--on_surface) !important;
    --topicTag-bgColor: var(--primary_container) !important;
    --topicTag-fgColor: var(--on_primary_container) !important;
    --label-bgColor-accent: var(--primary_container) !important;
    --label-fgColor-accent: var(--on_primary_container) !important;
    --label-bgColor-attention: var(--secondary_container) !important;
    --label-fgColor-attention: var(--on_secondary_container) !important;
    --label-bgColor-danger: var(--error_container) !important;
    --label-fgColor-danger: var(--on_error_container) !important;
    --label-bgColor-success: var(--tertiary_container) !important;
    --label-fgColor-success: var(--on_tertiary_container) !important;
    --shadow-resting-medium: none !important;
    --shadow-floating-medium: none !important;
    --color-ansi-black: var(--surface) !important;
    --color-ansi-white: var(--on_surface) !important;
    --color-ansi-cyan: var(--tertiary) !important;
    --color-ansi-green: var(--tertiary) !important;
    --color-ansi-red: var(--error) !important;
    --color-ansi-yellow: var(--secondary) !important;
    --color-ansi-blue: var(--primary) !important;
    --color-ansi-magenta: var(--secondary_container) !important;
    --color-ansi-bright-black: var(--surface_variant) !important;
    --color-ansi-bright-white: var(--on_surface_variant) !important;
}

/* Notification dot / indicator */
.notification-indicator .mail-status,
.indicator-green {
    background-color: var(--primary) !important;
}

/* Header search */
.header-search-button,
.Header-search-button {
    background-color: var(--surface_container_low) !important;
    border: 1px solid var(--outline_variant) !important;
    color: var(--on_surface_variant) !important;
}

/* Footer */
footer.footer,
.page-footer {
    background-color: var(--surface_container) !important;
    border-top: 1px solid var(--outline_variant) !important;
}

/* Diff — code review */
.blob-num,
.blob-code,
.blob-wrapper,
.diff-table,
.js-file-line-container {
    background-color: var(--surface_container_low) !important;
}

.blob-num-hover,
.blob-num:hover {
    background-color: var(--surface_container_high) !important;
}

/* Code blocks */
.highlight,
pre,
code,
.pl-c,
.pl-ent,
.pl-e,
.pl-k {
    color: var(--on_surface) !important;
}

/* Dialog / modal */
Overlay--show,
.Overlay-overlay,
.Overlay-header,
.Overlay-body,
.Overlay-footer {
    background-color: var(--surface) !important;
    border-color: var(--outline_variant) !important;
}

/* Tabs */
tabnav-tab,
.TabNav-item,
.UnderlineNav-item {
    background-color: transparent !important;
    border-color: transparent !important;
    color: var(--on_surface_variant) !important;
}

tabnav-tab[aria-current="page"],
.TabNav-item[aria-current="page"],
.UnderlineNav-item[aria-current="page"],
.UnderlineNav-item.selected {
    border-bottom-color: var(--primary) !important;
    color: var(--primary) !important;
}
}

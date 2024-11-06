import { globalOpacity } from "variables"

// target css file
const tmpCss = `/tmp/tmp-style.css`
const tmpScss = `/tmp/tmp-style.scss`
const cache_dir = `${App.configDir}/../../.cache`
const scss_dir = `${App.configDir}/scss`

const defaultColors = `${App.configDir}/scss/defaultColors.scss`

export const getCssPath = () => tmpCss

export function refreshCss()
{
    // main scss file
    const scss = `${App.configDir}/scss/style.scss`

    const response = Utils.exec(`bash -c "echo '$OPACITY: ${globalOpacity.value};' | cat - ${defaultColors} ${scss} > ${tmpScss} | sassc ${tmpScss} ${tmpCss} -I ${scss_dir} -I ${cache_dir}"`)
    print(response)
    if (response != "") Utils.notify(response)
    App.resetCss()
    App.applyCss(tmpCss)
}

Utils.monitorFile(
    // directory that contains the scss files
    `${App.configDir}/scss`,
    () => refreshCss()
)

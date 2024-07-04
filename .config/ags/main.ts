import "lib/session"
import "style/style"
import init from "lib/init"
import options from "options"
import Bar from "widget/bar/Bar"
import Launcher from "widget/launcher/Launcher"
import NotificationPopups from "widget/notifications/NotificationPopups"
import OSD from "widget/osd/OSD"
import Overview from "widget/overview/Overview"
import PowerMenu from "widget/powermenu/PowerMenu"
import ScreenCorners from "widget/bar/ScreenCorners"
import SettingsDialog from "widget/settings/SettingsDialog"
import Verification from "widget/powermenu/Verification"
import { forMonitors } from "lib/utils"
import { setupQuickSettings } from "widget/quicksettings/QuickSettings"
import { setupDateMenu } from "widget/datemenu/DateMenu"

App.config({
    onConfigParsed: () => {
        setupQuickSettings()
        setupDateMenu()
        init()
    },
    closeWindowDelay: {
        "launcher": 200, // milliseconds
        "overview": 200, // milliseconds
        "quicksettings": 200, // milliseconds
        "datemenu": 200, // milliseconds
    },
    windows: () => [
        ...forMonitors(Bar),
        ...forMonitors(NotificationPopups),
        ...forMonitors(ScreenCorners),
        ...forMonitors(OSD),
        Launcher(),
        Overview(),
        PowerMenu(),
        SettingsDialog(),
        Verification(),
    ],
})

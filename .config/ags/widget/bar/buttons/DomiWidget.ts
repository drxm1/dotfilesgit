import PanelButton from "../PanelButton"
const hyprland = await Service.import('hyprland')

export default () => PanelButton({
    window: "domi_widget",
    child: Widget.Label({
      label: hyprland.active.client.bind('title'),
      visible: hyprland.active.client.bind('address')
          .as(addr => !!addr),
    }),
})

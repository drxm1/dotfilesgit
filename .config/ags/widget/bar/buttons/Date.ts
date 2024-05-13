import { clock } from "lib/variables"
import PanelButton from "../PanelButton"
import options from "options"

const { format, action } = options.bar.date
const time = Utils.derive([clock, format], (c, f) => c.format(f) || "")

const DomiClock = () => 
  Widget.Label({
		className: 'clock',
		connections: [
			// this is bad practice, since exec() will block the main event loop
			// in the case of a simple date its not really a problem
			[1000, (self) => (self.label = exec('date "+%H:%M:%S %b %e."'))],

			// this is what you should do
			[
				1000,
				(self) =>
					execAsync(['date', '+%H:%M:%S %b %e.'])
						.then((date) => (self.label = date))
						.catch(console.error),
			],
		],
	});

export default () => PanelButton({
    window: "datemenu",
    on_clicked: action.bind(),
    child: Widget.Label({
        justification: "center",
        label: time.bind(),
    }),
})

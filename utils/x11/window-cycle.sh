# Cycle windows with Alt + Tab

WINDOW=$(xdotool search --sync --onlyvisible --name ".+" | head -1)

xdotool windowraise $WINDOW
xdotool windowfocus $WINDOW

set-option -g default-shell /usr/local/bin/zsh 
set-window-option -g xterm-keys on
set -g prefix C-a
unbind C-b
#setw -g mode-mouse off
#setw -g mouse-select-window on
#setw -g mouse-select-pane on
#setw -g mouse-resize-pane on
set -g base-index 1
setw -g pane-base-index 1
#set -g status-right "#[fg=cyan]#H" 
#set -g status-fg white
#set -g status-bg black
set -g message-fg white
set -g message-bg black
set -g message-attr bright
# 开启活动通知
setw -g monitor-activity on
set -g visual-activity on

#setw -g window-status-fg cyan
#setw -g window-status-bg default
#setw -g window-status-attr dim
#setw -g window-status-current-fg black
#setw -g window-status-current-bg white
#setw -g window-status-current-attr bright

#set -g pane-border-fg green
#set -g pane-border-bg black
set -g pane-active-border-fg white
set -g pane-active-border-bg yellow
set-option -g renumber-windows on

set-window-option -g mode-keys vi
set -g history-limit 500000
set -g monitor-activity on
set -g visual-activity off
set-window-option -g automatic-rename

bind-key c new-window -c "#{pane_current_path}" -n ''
bind R source-file ~/.tmux.conf \; display "Reloaded!"
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind H resize-pane -L 5
bind J resize-pane -D 5
bind K resize-pane -U 5
bind L resize-pane -R 5
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+
bind-key -r C-j swap-window -t -1
bind-key -r C-k swap-window -t +1
bind -n C-l send-keys C-l \; clear-history
bind b capture-pane -S -2000000 \; save-buffer ~/buffer
bind C-a send-prefix
set -g status-left-length 50
set -g status-right-length 150

set -g status-fg white
set -g status-bg colour234
set -g window-status-activity-attr bold
set -g pane-border-fg colour245
set -g pane-active-border-fg colour39
set -g message-fg colour16
set -g message-bg colour221
set -g message-attr bold
set -g display-panes-time 9000
bind-key -Tcopy-mode-vi 'v' send -X begin-selection
#bind-key -Tcopy-mode-vi 'y' send -X copy-selection
bind-key -Tcopy-mode-vi 'y' send -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
#bind-key -T copy-mode y send-keys -X copy-pipe-and-cancel 'reattach-to-user-namespace pbcopy'

set -g status-left '#[fg=colour235,bg=colour252,bold] ❐ #S#[fg=colour252,bg=colour234,bold]⮀'
set -g window-status-format "#[fg=white,bg=colour234] #I #W "
set -g window-status-current-format "#[fg=colour234,bg=colour32]⮀#[fg=colour234,bg=colour32,noreverse,bold] #I ⮁ #W #[fg=colour32,bg=colour234,nobold]⮀"
host_name=""
set -g status-right "#[fg=colour233,bg=colour245,bold] %H:%M $host_name"
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @resurrect-strategy-vim 'session'
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-save-shell-history 'on'
set -g @continuum-save-interval '30'
set -g @continuum-restore 'on'


run '~/.tmux/plugins/tpm/tpm'

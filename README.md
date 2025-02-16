# agenda_management

agenda_management

A new Flutter project for managing agendas efficiently.

Overview

The agenda_management application helps users organize and manage agendas by date, allowing them to track progress and assign members to each agenda item. The app provides an intuitive UI for scheduling agendas, selecting time slots, and assigning presenters or speakers.

Features

Screen 1: Show Agendas

Display agendas based on dates, labeled as Day 1, Day 2, Day 3, etc.

Show members in a stacked format (only 3 visible, rest shown as a count).

Use time flow dots and circles to indicate agenda status:

Filled blue circle: Agenda is completed.

Empty blue circle: Agenda is in progress.

Empty grey circle: Upcoming agenda.

Display agenda days in incremental order based on created dates.

Dynamic day adjustments when a new agenda is added.

Screen 2: Add an Agenda

Calendar week starts from Sunday and ends on Saturday.

Initially selected date defaults to today's date.

Navigation arrows allow switching between weeks but cannot go back to previous weeks.

Cannot select past dates.

Start/End time selection via DateTime picker.

Agenda description input using TextField Widget.

Selecting Presenters/Speakers navigates to Screen 3.

Screen 3: Add Member/Guest

Predefined hardcoded list of members.

Dynamically render profile stack based on available space, rest shown as count.

Selected members get a checkmark and appear in the stacked profile list.

Tech Stack

Flutter (Dart)

Riverpod (State Management) 
Hive  (Local Storage)
#!/bin/bash

APP="iOSTutorial"

ibtool --import-strings-file MainStoryboard_es.strings --write ../$APP/es.lproj/MainStoryboard.storyboard ../$APP/en.lproj/MainStoryboard.storyboard


import funkin.game.GameOverSubstate;
import funkin.menus.PauseSubState;
import funkin.menus.BetaWarningState;

import funkin.backend.utils.WindowUtils;
import openfl.Lib;
import lime.graphics.Image;

import hxvlc.util.Handle;

static var curMainMenuSelected:Int = 0;
static var curStoryMenuSelected:Int = 0;
static var moustacheMode:Bool = false;
static var catbotEnabled:Bool = false;

static var seenMenuCutscene:Bool = false;

static var windowTitleGOREFIELD:String = "Friday Night Funkin': Gorefield V2";

public static var weekProgress:Map<String, {song:String, weekMisees:Int, weekScore:Int, deaths:Int}> = [];

static var redirectStates:Map<FlxState, String> = [
    StoryMenuState => "gorefield/StoryMenuScreen"
];

function new() {
    Handle.init([]);
    FlxG.save.bind('V2', 'Gorefield');

    // MECHANICS
    FlxG.save.data.baby ??= false;
    FlxG.save.data.ps_hard ??= false;
    FlxG.save.data.scare_hard ??= false;
    FlxG.save.data.blue_hard ??= false;
    FlxG.save.data.orange_hard ??= false;

    // VISUALS
    FlxG.save.data.bloom ??= true;
    FlxG.save.data.glitch ??= true;
    FlxG.save.data.warp ??= true;
    FlxG.save.data.wrath ??= true;
    FlxG.save.data.heatwave ??= true;
    FlxG.save.data.static ??= true;
    FlxG.save.data.drunk ??= true;
    FlxG.save.data.vhs ??= true;
    FlxG.save.data.saturation ??= true;

    FlxG.save.data.trails ??= true;
    FlxG.save.data.particles ??= true;
    FlxG.save.data.flashing ??= true;

    //PROGRESSION
    FlxG.save.data.weeksFinished ??= [false, false, false, false, false, false];
    FlxG.save.data.codesUnlocked ??= false;
    FlxG.save.data.weeksUnlocked ??= [true, false, false, false, false, false, false, false];

    FlxG.save.data.beatWeekG1 ??= false;
    FlxG.save.data.beatWeekG2 ??= false;
    FlxG.save.data.beatWeekG3 ??= false;
    FlxG.save.data.beatWeekG4 ??= false;
    FlxG.save.data.beatWeekG5 ??= false;
    FlxG.save.data.beatWeekG6 ??= false;
    FlxG.save.data.beatWeekG7 ??= false;
    FlxG.save.data.beatWeekG8 ??= false;
    FlxG.save.data.firstTimeLanguage ??= true;

    FlxG.save.data.weekProgress ??= ["" => {}];
    weekProgress = FlxG.save.data.weekProgress;
    // CODES 
    FlxG.save.data.extrasSongs ??= [];
    FlxG.save.data.extrasSongsIcons ??= [];
    FlxG.save.data.codesList ??= ["HUMUNGOSAURIO", "PUEBLO MARRON", "ALTERCAT"];

    // EASTER EGG
    FlxG.save.data.canVisitArlene ??= false;
    FlxG.save.data.hasVisitedPhase ??= false;
    FlxG.save.data.paintPosition ??= -1;
    FlxG.save.data.arlenePhase ??= 0;
    
    // CREDITS
    FlxG.save.data.alreadySeenCredits ??= false;

    // OTHER
    FlxG.save.data.spanish ??= false;
    FlxG.save.data.dev ??= false;

    Lib.application.onExit.add(function(i:Int) {
        FlxG.save.data.weekProgress = weekProgress;
        FlxG.save.flush();
        trace("Saving Week Progress...");
    });
}

function preStateSwitch() {
    WindowUtils.resetTitle();
    window.title = windowTitleGOREFIELD;
    FlxG.camera.bgColor = 0xFF000000;

    if (Std.isOfType(FlxG.state, PlayState) && (FlxG.state.subState == null ? true : !Std.isOfType(FlxG.state.subState, GameOverSubstate) && !Std.isOfType(FlxG.state.subState, PauseSubState)) // ! CHECK IN GAME/NOT IN GAME OVER
        && Std.isOfType(FlxG.game._requestedState, PlayState) && PlayState.isStoryMode) // ! CHECK STORY MODE/ GOING TO OTHER SONG
        {FlxG.switchState(new ModState("gorefield/LoadingScreen")); return;} // LOADING SCREEN

    for (redirectState in redirectStates.keys()) 
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

function destroy() {FlxG.camera.bgColor = 0xFF000000;
    FlxG.save.bind('save-default', 'CodenameEngine');
}
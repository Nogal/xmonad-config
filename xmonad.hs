--Nogal's XMonad Setup
--

-- ============================Key Bindings=========================== --
----------------------------Launch Application---------------------------
-- Super + Space                     Application Launcher
-- Super + F                         File Manager
-- Super + W                         Web Client
-- Super + M                         Mail Client
-- Super + T                         Terminal

-------------------------------Navigation--------------------------------
-- Super + [1 - 9]			         Move to workspace N
-- Super + Shift + [1 - 9]		     Move Window to workspace 

--------------------------Window/Layout Management-----------------------
-- Alt + H/L                         Shink/Expand Mater Area
-- Alt + w/v                         Swap Focused Display
-- Alt + W/V                         Send Window to Focused Display
-- Alt + D/G                         Mirror Shrink/Expand
-- Alt + ,/.                         Increment/Deincrement Master Area
-- Alt + j/k                         Cycle active window  
-- Alt + Shift + j/k                 Move Window along Window Cycle
-- Alt + f                           Toggle Fullscreen
-- Alt + m                           Focus Master Window
-- Alt + Shift + C                   Kill Focused Window
-- Alt + Click                       Pull Window to Floating Position
-- Alt + t                           Tile Floating Window
-- Alt + Escape                      Toggle Panel
-- Alt + q                           Recompile XMonad
-- Alt + Shift + Delete              Quit XMonad
 
import XMonad hiding ( (|||) )
import XMonad.Actions.CycleWS
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Layout hiding ( (|||) )
import XMonad.Layout.Circle
import XMonad.Layout.Fullscreen
import XMonad.Layout.GridVariants
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Master
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spiral
import XMonad.Layout.ToggleLayouts
import XMonad.Util.EZConfig
import System.Exit
import System.IO

manageHook = manageDocks
myLayout =  avoidStruts $ smartBorders $ toggleLayouts Full (tiled) 
    ||| toggleLayouts Full (Mirror (tiled)) ||| toggleLayouts Full 
    (mastered (1/100) (1/2) $ SplitGrid XMonad.Layout.GridVariants.L 
    2 3 (2/3) (16/10) (5/100)) ||| toggleLayouts Full Circle 
    where 
            tiled   = ResizableTall nmaster delta frac slaves
            nmaster = 1
            frac    = 1/2
            delta   = 3/100
            slaves  = [] 

main = xmonad $ desktopConfig 
        { modMask = mod1Mask
        , layoutHook = myLayout 
        , handleEventHook = docksEventHook <+> fullscreenEventHook <+> 
        handleEventHook desktopConfig
        , focusedBorderColor = "#663399" }
         `removeKeysP` [("M1-S-q")]
         `additionalKeysP`
         [ ("M1-d", sendMessage MirrorShrink)
         , ("M1-g", sendMessage MirrorExpand)
         , ("M1-w", nextScreen)
         , ("M1-S-w", shiftNextScreen >> nextScreen)
         , ("M1-v", prevScreen)
         , ("M1-S-v", shiftPrevScreen >> prevScreen)
         , ("M1-S-<KP_Add>", sendMessage $ IncMasterCols 1)
         , ("M1-S-<KP_Subtract>", sendMessage $ IncMasterCols (-1))
         , ("M1-<KP_Add>", sendMessage $ IncMasterRows 1)
         , ("M1-<KP_Subtract>", sendMessage $ IncMasterRows (-1))
         , ("M1-f", sendMessage $ Toggle  "Full") 
         , ("M1-S-<Space>", sendMessage $ JumpToLayout "Circle") 
         , ("M1-<Escape>", sendMessage ToggleStruts) 
         , ("M1-S-<Delete>", io (exitWith ExitSuccess)) 
         , ("<XF86AudioLowerVolume>", spawn "amixer -q -D pulse -c 0 set Master 2dB- && ~/.xmonad/dzen-plugin")
         , ("<XF86AudioRaiseVolume>", spawn "amixer -q -D pulse -c 0 set Master 2dB+ && ~/.xmonad/dzen-plugin")
         , ("<XF86AudioMute>", spawn "amixer -q -D pulse set Master 1+ toggle")
         , ("<XF86Video>", spawn "rhythmbox")
         , ("M4-<Space>", spawn "synapse")
         , ("M4-w", spawn "firefox")
         , ("M4-m", spawn "thunderbird")
         , ("M4-t", spawn "terminator")
         , ("M4-f", spawn "nemo")
         ]

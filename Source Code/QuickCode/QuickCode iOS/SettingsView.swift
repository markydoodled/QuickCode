//
//  SettingsView.swift
//  QuickCode iOS
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI
import MessageUI
import CodeMirror_SwiftUI

struct SettingsView: View {
    //Setup Mail Sheet View And Result Trackers
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    var body: some View {
        //Show Settings Sections In A Form
        Form {
            EditorSettings()
            ThemesSettings()
            misc
        }
        .navigationTitle("Settings")
    }
    //Misc Settings Section
    var misc: some View {
        Section {
            //Version Text
            LabeledContent("Version", value: "1.0")
            //Build Text
            LabeledContent("Build", value: "1")
            //Button To Send Feedback
            Button(action: {isShowingMailView.toggle()}) {
                Text("Send Feedback")
            }
            //Feedback Mail View Sheet
            .sheet(isPresented: $isShowingMailView) {
                MailView(isShowing: self.$isShowingMailView, result: self.$result)
            }
        } header: {
            Label("Misc.", systemImage: "info.circle")
        }
    }
}

struct ThemesSettings: View {
    //Store Editor Syntax And Theme Selection
    @AppStorage("selectedSyntax") var selectedSyntax = 51
    @AppStorage("selectedTheme") var selectedTheme = 80
    @AppStorage("syntax") var syntax: CodeMode = CodeMode.text
    @AppStorage("theme") var theme: CodeViewTheme = CodeViewTheme.zenburnesque
    var body: some View {
        //Example Code Editor View
        Section {
            CodeView(theme: theme, code: .constant("Hello World"), mode: syntax.mode(), fontSize: 12, showInvisibleCharacters: false, lineWrapping: false)
        }
        //Theme Picker
        Section {
            Picker(selection: $selectedTheme, label: Text("Theme")) {
                Group {
                    Group {
                        Button(action: {}) {
                            Text("BB Edit")
                        }
                        .tag(1)
                        Button(action: {}) {
                            Text("All Hallow Eve")
                        }
                        .tag(2)
                        Button(action: {}) {
                            Text("Idle Fingers")
                        }
                        .tag(3)
                        Button(action: {}) {
                            Text("Space Cadet")
                        }
                        .tag(4)
                        Button(action: {}) {
                            Text("Idle")
                        }
                        .tag(5)
                        Button(action: {}) {
                            Text("Oceanic")
                        }
                        .tag(6)
                        Button(action: {}) {
                            Text("Clouds")
                        }
                        .tag(7)
                        Button(action: {}) {
                            Text("GitHub")
                        }
                        .tag(8)
                        Button(action: {}) {
                            Text("Ryan Light")
                        }
                        .tag(9)
                        Button(action: {}) {
                            Text("Black Pearl")
                        }
                        .tag(10)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Mono Industrial")
                        }
                        .tag(11)
                        Button(action: {}) {
                            Text("Happy Happy Joy Joy 2")
                        }
                        .tag(12)
                        Button(action: {}) {
                            Text("Cube 2 Media")
                        }
                        .tag(13)
                        Button(action: {}) {
                            Text("Friendship Bracelet")
                        }
                        .tag(14)
                        Button(action: {}) {
                            Text("Classic Modififed")
                        }
                        .tag(15)
                        Button(action: {}) {
                            Text("Amy")
                        }
                        .tag(16)
                        Button(action: {}) {
                            Text("Demo")
                        }
                        .tag(17)
                        Button(action: {}) {
                            Text("R Dark")
                        }
                        .tag(18)
                        Button(action: {}) {
                            Text("Espresso")
                        }
                        .tag(19)
                        Button(action: {}) {
                            Text("Sunburst")
                        }
                        .tag(20)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Made Of Code")
                        }
                        .tag(21)
                        Button(action: {}) {
                            Text("Arona")
                        }
                        .tag(22)
                        Button(action: {}) {
                            Text("Putty")
                        }
                        .tag(23)
                        Button(action: {}) {
                            Text("Night Lion")
                        }
                        .tag(24)
                        Button(action: {}) {
                            Text("Sidewalk Chalk")
                        }
                        .tag(25)
                        Button(action: {}) {
                            Text("Swyphs II")
                        }
                        .tag(26)
                        Button(action: {}) {
                            Text("I Plastic")
                        }
                        .tag(27)
                        Button(action: {}) {
                            Text("Solarized (Light)")
                        }
                        .tag(28)
                        Button(action: {}) {
                            Text("Mac Classic")
                        }
                        .tag(29)
                        Button(action: {}) {
                            Text("Pastels On Dark")
                        }
                        .tag(30)
                    }
                    Group {
                        Button(action: {}) {
                            Text("IR Black")
                        }
                        .tag(31)
                        Button(action: {}) {
                            Text("Material")
                        }
                        .tag(32)
                        Button(action: {}) {
                            Text("Monokai Fannon Edition")
                        }
                        .tag(33)
                        Button(action: {}) {
                            Text("Monokai Bright")
                        }
                        .tag(34)
                        Button(action: {}) {
                            Text("Eiffel")
                        }
                        .tag(35)
                        Button(action: {}) {
                            Text("Base 16 Light")
                        }
                        .tag(36)
                        Button(action: {}) {
                            Text("Oceanic Muted")
                        }
                        .tag(37)
                        Button(action: {}) {
                            Text("Summer Fruit")
                        }
                        .tag(38)
                        Button(action: {}) {
                            Text("Espresso Libre")
                        }
                        .tag(39)
                        Button(action: {}) {
                            Text("KR Theme")
                        }
                        .tag(40)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Mreq")
                        }
                        .tag(41)
                        Button(action: {}) {
                            Text("Chanfle")
                        }
                        .tag(42)
                        Button(action: {}) {
                            Text("Venom")
                        }
                        .tag(43)
                        Button(action: {}) {
                            Text("Juicy")
                        }
                        .tag(44)
                        Button(action: {}) {
                            Text("Coda")
                        }
                        .tag(45)
                        Button(action: {}) {
                            Text("Fluid Vision")
                        }
                        .tag(46)
                        Button(action: {}) {
                            Text("Tomorrow Night Blue")
                        }
                        .tag(47)
                        Button(action: {}) {
                            Text("Migucwb (Amiga)")
                        }
                        .tag(48)
                        Button(action: {}) {
                            Text("Twilight")
                        }
                        .tag(49)
                        Button(action: {}) {
                            Text("Vibrant Ink")
                        }
                        .tag(50)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Summer Sun")
                        }
                        .tag(51)
                        Button(action: {}) {
                            Text("Monokai")
                        }
                        .tag(52)
                        Button(action: {}) {
                            Text("Rails Envy")
                        }
                        .tag(53)
                        Button(action: {}) {
                            Text("Merbivore")
                        }
                        .tag(54)
                        Button(action: {}) {
                            Text("Dracula")
                        }
                        .tag(55)
                        Button(action: {}) {
                            Text("Pastie")
                        }
                        .tag(56)
                        Button(action: {}) {
                            Text("Low Light")
                        }
                        .tag(57)
                        Button(action: {}) {
                            Text("Spectacular")
                        }
                        .tag(58)
                        Button(action: {}) {
                            Text("Smoothy")
                        }
                        .tag(59)
                        Button(action: {}) {
                            Text("Vibrant Fin")
                        }
                        .tag(60)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Blackboard")
                        }
                        .tag(61)
                        Button(action: {}) {
                            Text("Slush & Poppies")
                        }
                        .tag(62)
                        Button(action: {}) {
                            Text("Freckle")
                        }
                        .tag(63)
                        Button(action: {}) {
                            Text("Fantasy Script")
                        }
                        .tag(64)
                        Button(action: {}) {
                            Text("Tomorrow Night Eighties")
                        }
                        .tag(65)
                        Button(action: {}) {
                            Text("Rhuk")
                        }
                        .tag(66)
                        Button(action: {}) {
                            Text("Toy Chest")
                        }
                        .tag(67)
                        Button(action: {}) {
                            Text("Fake")
                        }
                        .tag(68)
                        Button(action: {}) {
                            Text("Emacs Strict")
                        }
                        .tag(69)
                        Button(action: {}) {
                            Text("Merbivore Soft")
                        }
                        .tag(70)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Fade To Grey")
                        }
                        .tag(71)
                        Button(action: {}) {
                            Text("Monokai Sublime")
                        }
                        .tag(72)
                        Button(action: {}) {
                            Text("Johnny")
                        }
                        .tag(73)
                        Button(action: {}) {
                            Text("Railscasts")
                        }
                        .tag(74)
                        Button(action: {}) {
                            Text("Argonaut")
                        }
                        .tag(75)
                        Button(action: {}) {
                            Text("Tomorrow Night Bright")
                        }
                        .tag(76)
                        Button(action: {}) {
                            Text("Lazy")
                        }
                        .tag(77)
                        Button(action: {}) {
                            Text("Tomorrow Night")
                        }
                        .tag(78)
                        Button(action: {}) {
                            Text("Bongzilla")
                        }
                        .tag(79)
                        Button(action: {}) {
                            Text("Zenburnesque")
                        }
                        .tag(80)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Notebook")
                        }
                        .tag(81)
                        Button(action: {}) {
                            Text("Django (Smoothy)")
                        }
                        .tag(82)
                        Button(action: {}) {
                            Text("Blackboard Black")
                        }
                        .tag(83)
                        Button(action: {}) {
                            Text("Black Pearl II")
                        }
                        .tag(84)
                        Button(action: {}) {
                            Text("Kuroir")
                        }
                        .tag(85)
                        Button(action: {}) {
                            Text("Cobalt")
                        }
                        .tag(86)
                        Button(action: {}) {
                            Text("Ayu-Mirage")
                        }
                        .tag(87)
                        Button(action: {}) {
                            Text("Chrome DevTools")
                        }
                        .tag(88)
                        Button(action: {}) {
                            Text("Prospettiva")
                        }
                        .tag(89)
                        Button(action: {}) {
                            Text("Espresso Soda")
                        }
                        .tag(90)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Birds Of Paradise")
                        }
                        .tag(91)
                        Button(action: {}) {
                            Text("Text Ex Machina")
                        }
                        .tag(92)
                        Button(action: {}) {
                            Text("Django")
                        }
                        .tag(93)
                        Button(action: {}) {
                            Text("Tomorrow")
                        }
                        .tag(94)
                        Button(action: {}) {
                            Text("Solarized (Dark)")
                        }
                        .tag(95)
                        Button(action: {}) {
                            Text("Plastic Code Wrap")
                        }
                        .tag(96)
                        Button(action: {}) {
                            Text("Material Palenight")
                        }
                        .tag(97)
                        Button(action: {}) {
                            Text("Bespin")
                        }
                        .tag(98)
                        Button(action: {}) {
                            Text("Espresso Tutti")
                        }
                        .tag(99)
                        Button(action: {}) {
                            Text("Vibrant Tango")
                        }
                        .tag(100)
                    }
                }
                Group {
                    Button(action: {}) {
                        Text("Tubster")
                    }
                    .tag(101)
                    Button(action: {}) {
                        Text("Dark Pastel")
                    }
                    .tag(102)
                    Button(action: {}) {
                        Text("Dawn")
                    }
                    .tag(103)
                    Button(action: {}) {
                        Text("Tango")
                    }
                    .tag(104)
                    Button(action: {}) {
                        Text("Clouds Midnight")
                    }
                    .tag(105)
                    Button(action: {}) {
                        Text("Glitterbomb")
                    }
                    .tag(106)
                    Button(action: {}) {
                        Text("IR White")
                    }
                    .tag(107)
                }
            }
            .pickerStyle(.menu)
            //Detect Changes In The Theme Picker
            .onChange(of: selectedTheme) {
                if selectedTheme == 1 {
                    self.theme = CodeViewTheme.bbedit
                }
                if selectedTheme == 2 {
                    self.theme = CodeViewTheme.allHallowEve
                }
                if selectedTheme == 3 {
                    self.theme = CodeViewTheme.idleFingers
                }
                if selectedTheme == 4 {
                    self.theme = CodeViewTheme.spaceCadet
                }
                if selectedTheme == 5 {
                    self.theme = CodeViewTheme.idle
                }
                if selectedTheme == 6 {
                    self.theme = CodeViewTheme.oceanic
                }
                if selectedTheme == 7 {
                    self.theme = CodeViewTheme.clouds
                }
                if selectedTheme == 8 {
                    self.theme = CodeViewTheme.github
                }
                if selectedTheme == 9 {
                    self.theme = CodeViewTheme.ryanLight
                }
                if selectedTheme == 10 {
                    self.theme = CodeViewTheme.blackPearl
                }
                if selectedTheme == 11 {
                    self.theme = CodeViewTheme.monoIndustrial
                }
                if selectedTheme == 12 {
                    self.theme = CodeViewTheme.happyHappyJoyJoy2
                }
                if selectedTheme == 13 {
                    self.theme = CodeViewTheme.cube2Media
                }
                if selectedTheme == 14 {
                    self.theme = CodeViewTheme.friendshipBracelet
                }
                if selectedTheme == 15 {
                    self.theme = CodeViewTheme.classicModified
                }
                if selectedTheme == 16 {
                    self.theme = CodeViewTheme.amy
                }
                if selectedTheme == 17 {
                    self.theme = CodeViewTheme.default
                }
                if selectedTheme == 18 {
                    self.theme = CodeViewTheme.rdrak
                }
                if selectedTheme == 19 {
                    self.theme = CodeViewTheme.espresso
                }
                if selectedTheme == 20 {
                    self.theme = CodeViewTheme.sunburst
                }
                if selectedTheme == 21 {
                    self.theme = CodeViewTheme.madeOfCode
                }
                if selectedTheme == 22 {
                    self.theme = CodeViewTheme.arona
                }
                if selectedTheme == 23 {
                    self.theme = CodeViewTheme.putty
                }
                if selectedTheme == 24 {
                    self.theme = CodeViewTheme.nightlion
                }
                if selectedTheme == 25 {
                    self.theme = CodeViewTheme.sidewalkchalk
                }
                if selectedTheme == 26 {
                    self.theme = CodeViewTheme.swyphsii
                }
                if selectedTheme == 27 {
                    self.theme = CodeViewTheme.iplastic
                }
                if selectedTheme == 28 {
                    self.theme = CodeViewTheme.solarizedLight
                }
                if selectedTheme == 29 {
                    self.theme = CodeViewTheme.macClassic
                }
                if selectedTheme == 30 {
                    self.theme = CodeViewTheme.pastelsOnDark
                }
                if selectedTheme == 31 {
                    self.theme = CodeViewTheme.irBlack
                }
                if selectedTheme == 32 {
                    self.theme = CodeViewTheme.material
                }
                if selectedTheme == 33 {
                    self.theme = CodeViewTheme.monokaiFannonedition
                }
                if selectedTheme == 34 {
                    self.theme = CodeViewTheme.monokaiBright
                }
                if selectedTheme == 35 {
                    self.theme = CodeViewTheme.eiffel
                }
                if selectedTheme == 36 {
                    self.theme = CodeViewTheme.base16Light
                }
                if selectedTheme == 37 {
                    self.theme = CodeViewTheme.oceanicMuted
                }
                if selectedTheme == 38 {
                    self.theme = CodeViewTheme.summerfruit
                }
                if selectedTheme == 39 {
                    self.theme = CodeViewTheme.espressoLibre
                }
                if selectedTheme == 40 {
                    self.theme = CodeViewTheme.krtheme
                }
                if selectedTheme == 41 {
                    self.theme = CodeViewTheme.mreq
                }
                if selectedTheme == 42 {
                    self.theme = CodeViewTheme.chanfle
                }
                if selectedTheme == 43 {
                    self.theme = CodeViewTheme.venom
                }
                if selectedTheme == 44 {
                    self.theme = CodeViewTheme.juicy
                }
                if selectedTheme == 45 {
                    self.theme = CodeViewTheme.coda
                }
                if selectedTheme == 46 {
                    self.theme = CodeViewTheme.fluidvision
                }
                if selectedTheme == 47 {
                    self.theme = CodeViewTheme.tomorrowNightBlue
                }
                if selectedTheme == 48 {
                    self.theme = CodeViewTheme.magicwbAmiga
                }
                if selectedTheme == 49 {
                    self.theme = CodeViewTheme.twilight
                }
                if selectedTheme == 50 {
                    self.theme = CodeViewTheme.vibrantInk
                }
                if selectedTheme == 51 {
                    self.theme = CodeViewTheme.summerSun
                }
                if selectedTheme == 52 {
                    self.theme = CodeViewTheme.monokai
                }
                if selectedTheme == 53 {
                    self.theme = CodeViewTheme.railsEnvy
                }
                if selectedTheme == 54 {
                    self.theme = CodeViewTheme.merbivore
                }
                if selectedTheme == 55 {
                    self.theme = CodeViewTheme.dracula
                }
                if selectedTheme == 56 {
                    self.theme = CodeViewTheme.pastie
                }
                if selectedTheme == 57 {
                    self.theme = CodeViewTheme.lowlight
                }
                if selectedTheme == 58 {
                    self.theme = CodeViewTheme.spectacular
                }
                if selectedTheme == 59 {
                    self.theme = CodeViewTheme.smoothy
                }
                if selectedTheme == 60 {
                    self.theme = CodeViewTheme.vibrantFin
                }
                if selectedTheme == 61 {
                    self.theme = CodeViewTheme.blackboard
                }
                if selectedTheme == 62 {
                    self.theme = CodeViewTheme.slushPoppies
                }
                if selectedTheme == 63 {
                    self.theme = CodeViewTheme.freckle
                }
                if selectedTheme == 64 {
                    self.theme = CodeViewTheme.fantasyscript
                }
                if selectedTheme == 65 {
                    self.theme = CodeViewTheme.tomorrowNightEighties
                }
                if selectedTheme == 66 {
                    self.theme = CodeViewTheme.rhuk
                }
                if selectedTheme == 67 {
                    self.theme = CodeViewTheme.toyChest
                }
                if selectedTheme == 68 {
                    self.theme = CodeViewTheme.fake
                }
                if selectedTheme == 69 {
                    self.theme = CodeViewTheme.emacsStrict
                }
                if selectedTheme == 70 {
                    self.theme = CodeViewTheme.merbivoreSoft
                }
                if selectedTheme == 71 {
                    self.theme = CodeViewTheme.fadeToGrey
                }
                if selectedTheme == 72 {
                    self.theme = CodeViewTheme.monokaiSublime
                }
                if selectedTheme == 73 {
                    self.theme = CodeViewTheme.johnny
                }
                if selectedTheme == 74 {
                    self.theme = CodeViewTheme.railscasts
                }
                if selectedTheme == 75 {
                    self.theme = CodeViewTheme.argonaut
                }
                if selectedTheme == 76 {
                    self.theme = CodeViewTheme.tomorrowNightBright
                }
                if selectedTheme == 77 {
                    self.theme = CodeViewTheme.lazy
                }
                if selectedTheme == 78 {
                    self.theme = CodeViewTheme.tomorrowNight
                }
                if selectedTheme == 79 {
                    self.theme = CodeViewTheme.bongzilla
                }
                if selectedTheme == 80 {
                    self.theme = CodeViewTheme.zenburnesque
                }
                if selectedTheme == 81 {
                    self.theme = CodeViewTheme.notebook
                }
                if selectedTheme == 82 {
                    self.theme = CodeViewTheme.djangoSmoothy
                }
                if selectedTheme == 83 {
                    self.theme = CodeViewTheme.blackboardBlack
                }
                if selectedTheme == 84 {
                    self.theme = CodeViewTheme.blackPearlii
                }
                if selectedTheme == 85 {
                    self.theme = CodeViewTheme.kuroir
                }
                if selectedTheme == 86 {
                    self.theme = CodeViewTheme.cobalt
                }
                if selectedTheme == 87 {
                    self.theme = CodeViewTheme.ayuMirage
                }
                if selectedTheme == 88 {
                    self.theme = CodeViewTheme.chromeDevtools
                }
                if selectedTheme == 89 {
                    self.theme = CodeViewTheme.prospettiva
                }
                if selectedTheme == 90 {
                    self.theme = CodeViewTheme.espressoSoda
                }
                if selectedTheme == 91 {
                    self.theme = CodeViewTheme.birdsOfParadise
                }
                if selectedTheme == 92 {
                    self.theme = CodeViewTheme.textExMachina
                }
                if selectedTheme == 93 {
                    self.theme = CodeViewTheme.django
                }
                if selectedTheme == 94 {
                    self.theme = CodeViewTheme.tomorrow
                }
                if selectedTheme == 95 {
                    self.theme = CodeViewTheme.solarizedDark
                }
                if selectedTheme == 96 {
                    self.theme = CodeViewTheme.plasticcodewrap
                }
                if selectedTheme == 97 {
                    self.theme = CodeViewTheme.materialPalenight
                }
                if selectedTheme == 98 {
                    self.theme = CodeViewTheme.bespin
                }
                if selectedTheme == 99 {
                    self.theme = CodeViewTheme.espressoTutti
                }
                if selectedTheme == 100 {
                    self.theme = CodeViewTheme.vibrantTango
                }
                if selectedTheme == 101 {
                    self.theme = CodeViewTheme.tubster
                }
                if selectedTheme == 102 {
                    self.theme = CodeViewTheme.darkpastel
                }
                if selectedTheme == 103 {
                    self.theme = CodeViewTheme.dawn
                }
                if selectedTheme == 104 {
                    self.theme = CodeViewTheme.tango
                }
                if selectedTheme == 105 {
                    self.theme = CodeViewTheme.cloudsMidnight
                }
                if selectedTheme == 106 {
                    self.theme = CodeViewTheme.glitterbomb
                }
                if selectedTheme == 107 {
                    self.theme = CodeViewTheme.irWhite
                }
            }
            //Syntax Picker
            Picker(selection: $selectedSyntax, label: Text("Syntax")) {
                Group {
                    Button(action: {}) {
                        Text("APL")
                    }
                    .tag(1)
                    Button(action: {}) {
                        Text("PGP")
                    }
                    .tag(2)
                    Button(action: {}) {
                        Text("ASN")
                    }
                    .tag(3)
                    Button(action: {}) {
                        Text("C Make")
                    }
                    .tag(4)
                    Button(action: {}) {
                        Text("C")
                    }
                    .tag(5)
                    Button(action: {}) {
                        Text("C++")
                    }
                    .tag(6)
                    Button(action: {}) {
                        Text("Objective C")
                    }
                    .tag(7)
                    Button(action: {}) {
                        Text("Kotlin")
                    }
                    .tag(8)
                    Button(action: {}) {
                        Text("Scala")
                    }
                    .tag(9)
                    Button(action: {}) {
                        Text("C#")
                    }
                    .tag(10)
                }
                Group {
                    Button(action: {}) {
                        Text("Java")
                    }
                    .tag(11)
                    Button(action: {}) {
                        Text("Cobol")
                    }
                    .tag(12)
                    Button(action: {}) {
                        Text("Coffee Script")
                    }
                    .tag(13)
                    Button(action: {}) {
                        Text("Lisp")
                    }
                    .tag(14)
                    Button(action: {}) {
                        Text("CSS")
                    }
                    .tag(15)
                    Button(action: {}) {
                        Text("Django")
                    }
                    .tag(16)
                    Button(action: {}) {
                        Text("Docker File")
                    }
                    .tag(17)
                    Button(action: {}) {
                        Text("ERLang")
                    }
                    .tag(18)
                    Button(action: {}) {
                        Text("Fortran")
                    }
                    .tag(19)
                    Button(action: {}) {
                        Text("Go")
                    }
                    .tag(20)
                }
                Group {
                    Button(action: {}) {
                        Text("Groovy")
                    }
                    .tag(21)
                    Button(action: {}) {
                        Text("Haskell")
                    }
                    .tag(22)
                    Button(action: {}) {
                        Text("HTML")
                    }
                    .tag(23)
                    Button(action: {}) {
                        Text("HTTP")
                    }
                    .tag(24)
                    Button(action: {}) {
                        Text("Javascript")
                    }
                    .tag(25)
                    Button(action: {}) {
                        Text("Typescript")
                    }
                    .tag(26)
                    Button(action: {}) {
                        Text("JSON")
                    }
                    .tag(27)
                    Button(action: {}) {
                        Text("Ecma")
                    }
                    .tag(28)
                    Button(action: {}) {
                        Text("Jinja")
                    }
                    .tag(29)
                    Button(action: {}) {
                        Text("Lua")
                    }
                    .tag(30)
                }
                Group {
                    Button(action: {}) {
                        Text("Markdown")
                    }
                    .tag(31)
                    Button(action: {}) {
                        Text("Maths")
                    }
                    .tag(32)
                    Button(action: {}) {
                        Text("Pascal")
                    }
                    .tag(33)
                    Button(action: {}) {
                        Text("Perl")
                    }
                    .tag(34)
                    Button(action: {}) {
                        Text("PHP")
                    }
                    .tag(35)
                    Button(action: {}) {
                        Text("Powershell")
                    }
                    .tag(36)
                    Button(action: {}) {
                        Text("Properties")
                    }
                    .tag(37)
                    Button(action: {}) {
                        Text("protobuf")
                    }
                    .tag(38)
                    Button(action: {}) {
                        Text("Python")
                    }
                    .tag(39)
                    Button(action: {}) {
                        Text("R")
                    }
                    .tag(40)
                }
                Group {
                    Button(action: {}) {
                        Text("Ruby")
                    }
                    .tag(41)
                    Button(action: {}) {
                        Text("Rust")
                    }
                    .tag(42)
                    Button(action: {}) {
                        Text("Sass")
                    }
                    .tag(43)
                    Button(action: {}) {
                        Text("Scheme")
                    }
                    .tag(44)
                    Button(action: {}) {
                        Text("Shell")
                    }
                    .tag(45)
                    Button(action: {}) {
                        Text("SQL")
                    }
                    .tag(46)
                    Button(action: {}) {
                        Text("SQLite")
                    }
                    .tag(47)
                    Button(action: {}) {
                        Text("MySQL")
                    }
                    .tag(48)
                    Button(action: {}) {
                        Text("Latex")
                    }
                    .tag(49)
                    Button(action: {}) {
                        Text("Swift")
                    }
                    .tag(50)
                }
                Group {
                    Button(action: {}) {
                        Text("Text")
                    }
                    .tag(51)
                    Button(action: {}) {
                        Text("Toml")
                    }
                    .tag(52)
                    Button(action: {}) {
                        Text("VB")
                    }
                    .tag(53)
                    Button(action: {}) {
                        Text("Vue")
                    }
                    .tag(54)
                    Button(action: {}) {
                        Text("XML")
                    }
                    .tag(55)
                    Button(action: {}) {
                        Text("YAML")
                    }
                    .tag(56)
                    Button(action: {}) {
                        Text("Dart")
                    }
                    .tag(57)
                    Button(action: {}) {
                        Text("Ntriples")
                    }
                    .tag(58)
                    Button(action: {}) {
                        Text("Sparql")
                    }
                    .tag(59)
                    Button(action: {}) {
                        Text("Turtle")
                    }
                    .tag(60)
                }
            }
            .pickerStyle(.menu)
            //Detect Changes In The Syntax Picker
            .onChange(of: selectedSyntax) {
                if selectedSyntax == 1 {
                    self.syntax = CodeMode.apl
                }
                if selectedSyntax == 2 {
                    self.syntax = CodeMode.pgp
                }
                if selectedSyntax == 3 {
                    self.syntax = CodeMode.asn
                }
                if selectedSyntax == 4 {
                    self.syntax = CodeMode.cmake
                }
                if selectedSyntax == 5 {
                    self.syntax = CodeMode.c
                }
                if selectedSyntax == 6 {
                    self.syntax = CodeMode.cplus
                }
                if selectedSyntax == 7 {
                    self.syntax = CodeMode.objc
                }
                if selectedSyntax == 8 {
                    self.syntax = CodeMode.kotlin
                }
                if selectedSyntax == 9 {
                    self.syntax = CodeMode.scala
                }
                if selectedSyntax == 10 {
                    self.syntax = CodeMode.csharp
                }
                if selectedSyntax == 11 {
                    self.syntax = CodeMode.java
                }
                if selectedSyntax == 12 {
                    self.syntax = CodeMode.cobol
                }
                if selectedSyntax == 13 {
                    self.syntax = CodeMode.coffeescript
                }
                if selectedSyntax == 14 {
                    self.syntax = CodeMode.lisp
                }
                if selectedSyntax == 15 {
                    self.syntax = CodeMode.css
                }
                if selectedSyntax == 16 {
                    self.syntax = CodeMode.django
                }
                if selectedSyntax == 17 {
                    self.syntax = CodeMode.dockerfile
                }
                if selectedSyntax == 18 {
                    self.syntax = CodeMode.erlang
                }
                if selectedSyntax == 19 {
                    self.syntax = CodeMode.fortran
                }
                if selectedSyntax == 20 {
                    self.syntax = CodeMode.go
                }
                if selectedSyntax == 21 {
                    self.syntax = CodeMode.groovy
                }
                if selectedSyntax == 22 {
                    self.syntax = CodeMode.haskell
                }
                if selectedSyntax == 23 {
                    self.syntax = CodeMode.html
                }
                if selectedSyntax == 24 {
                    self.syntax = CodeMode.http
                }
                if selectedSyntax == 25 {
                    self.syntax = CodeMode.javascript
                }
                if selectedSyntax == 26 {
                    self.syntax = CodeMode.typescript
                }
                if selectedSyntax == 27 {
                    self.syntax = CodeMode.json
                }
                if selectedSyntax == 28 {
                    self.syntax = CodeMode.ecma
                }
                if selectedSyntax == 29 {
                    self.syntax = CodeMode.jinja
                }
                if selectedSyntax == 30 {
                    self.syntax = CodeMode.lua
                }
                if selectedSyntax == 31 {
                    self.syntax = CodeMode.markdown
                }
                if selectedSyntax == 32 {
                    self.syntax = CodeMode.maths
                }
                if selectedSyntax == 33 {
                    self.syntax = CodeMode.pascal
                }
                if selectedSyntax == 34 {
                    self.syntax = CodeMode.perl
                }
                if selectedSyntax == 35 {
                    self.syntax = CodeMode.php
                }
                if selectedSyntax == 36 {
                    self.syntax = CodeMode.powershell
                }
                if selectedSyntax == 37 {
                    self.syntax = CodeMode.properties
                }
                if selectedSyntax == 38 {
                    self.syntax = CodeMode.protobuf
                }
                if selectedSyntax == 39 {
                    self.syntax = CodeMode.python
                }
                if selectedSyntax == 40 {
                    self.syntax = CodeMode.r
                }
                if selectedSyntax == 41 {
                    self.syntax = CodeMode.ruby
                }
                if selectedSyntax == 42 {
                    self.syntax = CodeMode.rust
                }
                if selectedSyntax == 43 {
                    self.syntax = CodeMode.sass
                }
                if selectedSyntax == 44 {
                    self.syntax = CodeMode.scheme
                }
                if selectedSyntax == 45 {
                    self.syntax = CodeMode.shell
                }
                if selectedSyntax == 46 {
                    self.syntax = CodeMode.sql
                }
                if selectedSyntax == 47 {
                    self.syntax = CodeMode.sqllite
                }
                if selectedSyntax == 48 {
                    self.syntax = CodeMode.mysql
                }
                if selectedSyntax == 49 {
                    self.syntax = CodeMode.latex
                }
                if selectedSyntax == 50 {
                    self.syntax = CodeMode.swift
                }
                if selectedSyntax == 51 {
                    self.syntax = CodeMode.text
                }
                if selectedSyntax == 52 {
                    self.syntax = CodeMode.toml
                }
                if selectedSyntax == 53 {
                    self.syntax = CodeMode.vb
                }
                if selectedSyntax == 54 {
                    self.syntax = CodeMode.vue
                }
                if selectedSyntax == 55 {
                    self.syntax = CodeMode.xml
                }
                if selectedSyntax == 56 {
                    self.syntax = CodeMode.yaml
                }
                if selectedSyntax == 57 {
                    self.syntax = CodeMode.dart
                }
                if selectedSyntax == 58 {
                    self.syntax = CodeMode.ntriples
                }
                if selectedSyntax == 59 {
                    self.syntax = CodeMode.sparql
                }
                if selectedSyntax == 60 {
                    self.syntax = CodeMode.turtle
                }
            }
        } header: {
            Label("Themes", systemImage: "moon")
        }
    }
}

struct EditorSettings: View {
    //Store Editor Settings
    @AppStorage("lineWrapping") var lineWrapping = true
    @AppStorage("showInvisibleCharacters") var showInvisibleCharacters = false
    @AppStorage("fontSize") var fontSize = 12
    var body: some View {
        Section {
            //Font Size Stepper
            Stepper("Font Size - \(fontSize)", value: $fontSize, in: 1...120)
            //Toggle Line Wrapping
            Toggle(isOn: $lineWrapping) {
                Text("Line Wrapping")
            }
            .toggleStyle(.switch)
            //Toggle Showing Invisible Characters
            Toggle(isOn: $showInvisibleCharacters) {
                Text("Show Invisible Characters")
            }
            .toggleStyle(.switch)
        } header: {
            Label("Editor", systemImage: "pencil")
        }
    }
}

//Create Mail View To Send Feedback
struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(isShowing: Binding<Bool>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                isShowing = false
            }
            
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing, result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {

    }
}

#Preview {
    SettingsView()
}

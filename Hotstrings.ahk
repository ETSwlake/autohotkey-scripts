#Requires AutoHotkey v2.0

; Hotstrings are text that's replaced when you type them. I use a lot of them, they're super handy.
; READ MORE: https://www.autohotkey.com/docs/v2/Hotstrings.htm

; All my hotstrings start with a ; so that I unintentionally trigger any of them
; eg `::e::foo` --> triggers if I type ` e `, can easily happen by accident
; `::;e::` triggers if I type ` ;e `, never happens in day-to-day programming

; MATH STUFF
; O means it doesn't add a space after completing
; C means it is case sensitive

:O?:;pm::±
::;diam::∅
::;deg::°
::;degC::°C
::;degF::°F
::;inf::∞
::;approx::≈
::;neq::≠
::;leq::≤
::;geq::≥
:O:;sqrt::√
:O:;cbrt::∛
::;sqr::²
::;cube::³
:O:;sum::∑
:O:;prod::∏
:O:;int::∫
::;alpha::α
::;beta::β
::;gamma::γ
:C:;Delta::∆
:C:;delta::δ
::;epsilon::ε
::;zeta::ζ
::;eta::η
::;theta::θ
:C:;Lambda::Λ
:C:;lambda::λ
::;mu::μ
::;pi::π
::;rho::ρ
::;sigma::σ
:C:;Phi::Φ
:C:;phi::φ
::;psi::ψ
:C:;Omega::Ω
:C:;omega::ω

; Text stuff
; R means it won't parse {Space} as ' ' or `r as a newline
;  (probably unneeded but I like the peace of mind)
:RO:;en::–
:RO:;em::—
:R:;ddd::…
:RO:;terro::‽

; DATE FUNCTIONS
; Hotstrings can also trigger functions!
; See `>^>+d` in main.ahk for explanation of FormatTime
:R:;date:: 
{
    Send(FormatTime(,"M/d/yyyy"))
}

:R:;iso:: 
{
    Send(FormatTime(,"yyyy-MM-dd"))
}

; MISC STUFF


; AUTOGEN
; Anything added by the HotStringAdder.ahk will go below here.

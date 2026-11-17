# Speaker notes: student B

Your parts of the 15-minute talk:

| Time | Segment | Length |
|---|---|---|
| 6:00 – 8:00 | OMNeT++ design | 2 min |
| 11:30 – 14:00 | Live demo | 2.5 min |
| Q&A | Questions about simulation, experiments, reproducibility | 5 min, shared |

Anything in **[square brackets]** is a placeholder: replace it with your real names and numbers once the experiments are done. Only say what is true on the day. If a feature isn't finished, leave it out of the script.

## How to learn this

- **Memorise word for word:** your first two sentences, your last sentence, and both handovers. Those are the moments when nerves are worst.
- **Everything else:** memorise the key points in order, not the exact words. Speaking from points sounds natural; reciting sounds like reading.
- **Practise out loud, standing up, with a timer.** 2 minutes is about 260 words. If you run over, cut sentences rather than speaking faster.
- **Record yourself once on your phone** and listen back. That shows you where you rush or mumble.
- **Look at the audience, not the slide.** Point at the slide, then turn back.

---

## Segment 1: OMNeT++ design (6:00 – 8:00)

**A hands over to you:** "…Now [B's name] will show you how we built this in OMNeT++."

> **(memorise)** Thank you, [A's name]. Now that you've seen how the algorithm works, I'll show you how we turned it into a simulation.

*[Slide: three-layer diagram, NED / C++ / INI]*

> Our model has three layers.
>
> The first layer is the **topology**, written in NED. Every process is a simple module called Node3, with one two-way gate per neighbour. A network file just creates the nodes and connects them with links. Each link has a delay, and that delay is a parameter, so we can change it without touching the code.
>
> The second layer is the **behaviour**, in C++. When a node starts, it looks at its gates and builds its list of neighbours. When it receives the message for the first time, it compares its neighbours with the set Z, adds the missing ones to Z, and sends each of them a copy. Any later copy is counted as a duplicate and dropped. At the end, every node records its own numbers: messages sent, received, duplicates, and when it was first informed.
>
> The third layer is the **experiments**, in the INI file. One configuration describes a whole campaign. One line says "try a delay of 1, 5 and 10 milliseconds", another says "try every node as the initiator", and OMNeT++ generates every combination for us.

*[Slide: pipeline, generator → NED → Cmdenv → CSV → Python → figure]*

> Everything runs from the command line. A script runs each campaign in Cmdenv, [four] runs in parallel. Scavetool exports the results to CSV, and a Python script checks them and draws the figures. In total we ran **[N] simulations**.
>
> Before any experiment, we validated the model on seven small graphs where we knew the answer in advance: a line, a tree, a ring, and so on. All seven passed.

> **(memorise)** So we trust the model. [C's name] will now show you what it told us.

---

## Segment 2: Live demo (11:30 – 14:00)

**C hands over to you:** "…[B's name] will now show you the simulation running."

> **(memorise)** Thanks, [C's name]. Let me show you the simulation live.

*[Qtenv already open on Network3. Never start the demo from a closed program.]*

> This is the nine-node network from our example. Node 0 is the initiator.

*[Click **Step**]*

> Node 0 sends one message to node 1. If I open the message, you can see the set Z: just zero and one.

*[Step twice]*

> Node 1 forwards it to 2 and 4, and Z grows: zero, one, two and four.

*[Click **Run**]*

> And here's the interesting part. Nodes 5 and 8 send to each other at the same time. Each branch carries its own copy of Z, so neither one knows the other has already covered them. Those are the two duplicates from the trace.

*[Switch to the terminal, with the command already typed]*

> For the real experiments we don't click through runs one by one. This one command runs a whole campaign: here, [twelve] runs, one for each initiator on Abilene.

*[Press Enter]*

> …and it's done.

*[Open the CSV]*

> Each line is one measurement from one node in one run…

*[Open the figure]*

> …and our script turns it into the figure you saw a few minutes ago.

> **(memorise)** That's the whole pipeline, from a network file to a figure. Anyone can repeat it by following our README.

**If the live demo fails, stay calm and say:**

> It looks like the live demo isn't cooperating today, so let me show you the recording instead.

Have the backup video open in a second window before the talk starts.

---

## Questions you are likely to get

Answer in one or two sentences, then stop. A short, confident answer sounds better than a long one.

**"Why did you repeat runs if the algorithm is deterministic?"**
> We only repeat runs that contain something random: random link delays, crashes or message loss. Deterministic configurations run exactly once, because repeating them would give identical results.

**"How do you know your simulation is correct?"**
> We validated it on seven small graphs where we computed the answer by hand first. We also check in every run that the messages sent equal the messages received plus the messages lost.

**"What's the difference between simulation time and run time?"**
> Simulation time is time inside the model: how long the broadcast takes in the network. Run time is how long the computer takes to simulate it. Our results are about simulation time.

**"Why does the simulation stop?"**
> It stops when there are no more events, meaning no message is still travelling. We don't implement termination detection, so we report the time the last node was first informed.

**"How did you model failures?"**
> Crashed nodes are chosen before the broadcast starts, and the initiator never crashes. Lost messages are dropped independently with a fixed probability, and they're not retransmitted.

**"Why 1, 5 and 10 milliseconds?"**
> They're modelled delays to show the trend, not measured Internet latencies. We say that clearly in the report.

**"Why Cmdenv and not the graphical interface?"**
> The graphical interface is for understanding a single run. Cmdenv is much faster and can run many simulations in parallel, which is what you need for a campaign.

**"Could someone else reproduce your results?"**
> Yes. The README explains how to build and run everything, the configurations and seeds are in the INI file, and every figure is generated by a script from the raw results.

### When you don't know the answer

> That's a good question. We didn't test that directly, but what we can say is…

> Let me make sure I understood: you're asking whether…?

> I think [A's / C's name] can answer that better than me.

---

## Pronunciation of key words

Capitals show the stressed syllable.

| Word | Say it like |
|---|---|
| OMNeT++ | OM-net plus plus |
| diffuse (verb) | dih-FYOOZ |
| topology | tuh-POL-uh-jee |
| initiator | ih-NISH-ee-ay-ter |
| simulation | sim-yoo-LAY-shun |
| parameter | puh-RAM-ih-ter |
| algorithm | AL-guh-rith-um |
| analysis | uh-NAL-ih-sis |
| scalar | SKAY-ler |
| eccentricity | ek-sen-TRIS-ih-tee |
| Cmdenv | command env |
| Qtenv | cute env |
| INI file | "I-N-I file" or "ini file" |
| Abilene | AB-ih-leen |
| GÉANT | zhay-AHN (French: géant) |
| Germany50 | Germany fifty |

## Common traps for French speakers

Skip this if French isn't your first language.

| Avoid | Because in English it means | Say instead |
|---|---|---|
| "actually" for *actuellement* | "in fact" | "currently" or "now" |
| "eventually" for *éventuellement* | "in the end" | "possibly" |
| "realise" for *réaliser* | "understand suddenly" | "carry out", "build" or "run" |
| "assist to" for *assister à* | "help" | "attend" |

- **"-ed" endings are usually not a separate syllable.** "dropped" is one syllable (*dropt*), "informed" is two (*in-FORMD*). Only after a t or d sound do you add a syllable: "connected" is *con-NEK-tid*.
- **The "th" sound:** put the tip of your tongue between your teeth for *the*, *three*, *thank you*, *path*. Practise "the three paths" slowly.
- **Don't drop the "h":** *how*, *hypothesis* (*hy-POTH-ih-sis*), *hand-trace*.

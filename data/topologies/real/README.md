# Real Topologies (SNDlib)

Source: https://sndlib.put.poznan.pl
Downloaded: 2026-11-25
Role: C (Evaluation) — Step 5 of the project roadmap

## Files used

| Network | Raw file | Nodes | Links | NED file | Nodes CSV |
|---------|----------|-------|-------|----------|-----------|
| Abilene | `raw/abilene.txt` | 12 | 15 | `simulations/real/Abilene.ned` | `Abilene_nodes.csv` |
| Geant | `raw/geant.txt` | 22 | 36 | `simulations/real/Geant.ned` | `Geant_nodes.csv` |
| Germany50 | `raw/germany50.txt` | 50 | 88 | `simulations/real/Germany50.ned` | `Germany50_nodes.csv` |

## Format

Each raw file is in SNDlib native format, containing `NODES (` and `LINKS (` sections. The NED files were generated from these topology files by:

1. Sorting node names alphabetically and assigning IDs `0 .. n-1`.
2. Writing one undirected `node[i].gate++ <--> Link <--> node[j].gate++;` connection per link.
3. All links use the shared `Link` channel (default 1 ms delay).

Ignored: demand matrices, traffic traces, SRLGs, and other SNDlib artifacts not needed for broadcast simulation.

## Validation

- All three networks are fully connected (verified via BFS).
- Node/link counts match the roadmap specification (Abilene 12/15, Geant 22/36, Germany50 50/88).
- Each `_nodes.csv` contains: `id`, `name`, `degree`, `eccentricity` computed with BFS.

# Dialogue

This document is a first attempt at defining the requirements of Dialogue, an Inter Planetary Social Network. It analyzes the benefits and limitations of existing social networks to build toward an extensive list of requirements and features.

## Index

- Core Principles
- Tensions
- Success Metrics
- Requirements and Justifications
- Tooling

## Core Principles

These core principles might be idealistic and unreachable but they serve as a north star. Every requirement and every feature has to be justified and can be debated relative to these principles.

1. **Respectful**: Foster goodwill, empathy, openness and constructive communication.
2. **Purposeful**: Encourage mindful and intentional technology use.
3. **Expressive**: Enable creative expression and knowledge sharing regardless of economical background.
4. **Collective**: Make collective and democratic organizing and decision-making more efficient than centralized systems.
5. **Empowering**: Entrust people with control over their digital environment and support them with appropriate tools.
6. **Private**: Guarantee personal data sovereignty and communication confidentiality.
7. **Resilient**: Maintain platform availability even under state-level interdiction.
8. **Safe**: Ensure users can communicate without fear of identification or retribution even in repressive environments.
9. **Distributed**: Share computing and storage resources across devices to minimize environmental impact and ensure network independence.
10. **Accessible**: Ensure accessibility no matter the technical knowledge, the economical status, the cultural background, the physical disabilities, the language or the literacy.
11. **Modular**: Support community-driven development with a secure framework making every interface and algorithm customizable.
12. **Transparent**: Actively expose and explain all platform mechanisms, algorithmic systems, and community processes, enabling informed user participation and control.
13. **Empirical**: Justify every feature and study its concrete impact to ensure alignment with the *core principles*.
14. **Governance**: Organize platform governance in a way that ensures consistent adherence to the *core principles*.

## Tensions

Here we describe the various conditions under which some principles might be conflicting and the ways we want to resolve those tensions.

### Safety, Privacy, Distributed, Modular vs Accessibility

Strong safety often require technical complexity. Privacy oriented software often  management, distributed systems features . Managing who gets to access which data

## Success Metrics

Here we describe the metrics we will use to measure how well the platform follows each of its core principles.

## Requirements and Justifications

Here we describe a set of requirements that we justify in regards to the platform's core principles.

### Platform's Name

The platform's name has to:

- Emphasize the social aspect of the platform
- Have a meaning that mirrors the platform's *core principles*
- Be readable and pronounceable in a large amount of languages (*accessibility* principle)
- Be memorable

Some interesting names include:

- **Dialogue**
  - This is the current chosen name
  - Pros:
    - Reflects the *respectful*, *expressive* and *collective* principles
    - Is easy to pronounce and has the same meaning in many languages
    - There is a clear social aspect making it sensible to label a social network
- **Inter Planetary Social Network (IPSN)**
  - Pros:
    - Reflects the *distributed* and *resilient* principles
    - Emphasize the future proof aspect of the platform
    - The fact that it is a social network is explicitly stated
  - Cons:
    - Quite long and difficult to pronounce for non english speakers
    - Might be considered as piggy backing on the IPFS ecosystem even if it might not be built on top of it

### Programming Language

The choice of programming language is crucial as it must comply with tree principles

- Easy to learn and master
  - Enforces good practice through language design
  - Human readable and helpful error messages
  - Single threaded code
- Built for distributed and parallel architecture
  - CRDT as first class citizen
  - Computation complexity evaluation at compile time for automated parallelization and distribution of computations
- Must be easy to read and maintain
  - When it compiles it works
  - No implicit behavior
  - Strongly typed
- Must be easy to create sandboxes for users to code extensions while controlling which data it reads and writes (*modularity* principle)
  - Has no side effects

### Integrated Development Environment

We need a bunch of graphical tools for making the programming experience as smooth as possible

- Layout editor

The Elm architecture (time machine, ...).

## Tooling

Here we discuss which tools are needed to complete the requirements and weather potential candidates already exist.

## Legacy Text

### Pro-Social Behavior

- Users can make one to one or group chats.
- Users can post content and decide who gets access to it.

### Organization Tools

- Users form organizations and set rules for their functioning.
- Debate and messaging systems encourage constructive dialogue.
- Voting systems are modular and transparent to every member.
- Texts and rules can be collaboratively edited, reviewed and voted.
- Inclusion and expulsion mechanisms are set up as rules.
- Roles can be attributed and revoked via votes.
- Debate surrounding every rule and text is made available and structured in an accessible fashion.

### Content Moderation

- Content moderation is managed by the users.
- Individuals and organizations can provide custom algorithms and metrics as extensions.

### Accessible

- Low technical and cultural barriers.
- [Accessible](https://en.wikipedia.org/wiki/Computer_accessibility) to people with disabilities.

### International

- People should be able to communicate and organize across linguistic and national barriers.
- The design of the interface must be adaptable for various cultural and linguistic environments.

### Data Privacy

- Data has to be fully encrypted and under user's informed control.
- Defaults always protects user's privacy.
- Users have control over where they store their data.

### Local First and Fully Distributed

The app has to function as [local first software](https://www.inkandswitch.com/local-first/) so that it stays up even under heavy network partitioning.

**Principles**:

- Keep the primary copy of the data on the local device.
- Synchronize data across all of the user's devices.
- Works fine without an Internet connection.
- Support real-time collaboration.
- Downloadable from any other user's device.
- Users can take part in a [cooperative storage cloud](https://en.wikipedia.org/wiki/Cooperative_storage_cloud) for long term storage.
- Users can take part in cooperative [distributed computing](https://en.wikipedia.org/wiki/Distributed_computing) in order to run algorithms that are too heavy to function locally.

**Useful Inspirations**:

- [any-sync](https://github.com/anyproto/any-sync) for automatic conflict resolution.
- [automerge](https://automerge.org/) for automatic conflict resolution.
- [ipns](https://docs.ipfs.tech/concepts/ipns/) for content addressing.
- [socket-runtime](https://github.com/socketsupply/socket) for network buffering.

### Payment System

A payment solution has to be provided as many services required for the platform to function need money to be exchanged.

> Some of the principles below are mathematically impossible. They are quite naive and need more precision.

**Principles**:

- Secure and reliable.
- Anonymous and untraceable.
- Keeps working under heavy network partitioning.
- Byzantine resistant.

**Useful Inspirations**:

- [filecoin](https://filecoin.io/) as a cooperative storage cloud with a reward model, it also doubles as a crypto currency.

### Easy to Customize

Essentially everything in Dialogue has to be customizable for it to match all of its constraints.

**Principles**:

- The programming language used for extensions has to be easy to learn, debug and maintain.
- GUI are provided where possible.
- APIs accessed by extensions must be constrained enough to make code injection or the use of any other hacking methods impossible.

**Useful Inspirations**:

- [Elm](https://elm-lang.org/)

### Hard to Track

The software should withstand state level interdiction and make its users as innocuous as possible.

> This would be ideal but I'm out of my technical depth here.

**Principles**:

- The network communications made between clients have to be innocuous and untraceable.
- It should be possible to make the app hardly recognizable by any other software on the device.

**Useful Inspirations**:

- [Metamorphic code](https://en.wikipedia.org/wiki/Metamorphic_code) can be used to make the app unrecognizable.

### Development Financing

The shopping list is long and we will need a lot of resources to get there.

> This is the main pain point. How can we make people accountable?
> This section is very insufficient and idealistic in my opinion.

**Principles**:

- Money only is a mean to an end.
- Development must be done without any profit motive.
- Money is only used to free the most involved volunteers time.
- The hourly pay is fixed and equal for everyone.
- The way the development team is financed must be - if not aligned - at least compatible with the goals of the project otherwise it is better to only involve volunteers.

**Possible Revenue Sources**:

- Providing a market for easily exchanging the platform's currency with circulating ones.
- Consulting for companies and non profits that would like to function in a democratic fashion and would benefit by integrating Dialogue into their organization.
- User's donations under a set threshold to avoid large donators getting leverage.


## Design Ideas

- Detect aggressive or hurtful writing in a post or comment and prompt the user to think about the people that message might hurt before posting it online.
- Users can setup custom content flagging systems and share their flags with one an other.
- Users can code their own recommender systems.

- Different versions of the interface can be provided as extensions.
- Translation algorithms can be provided as extensions and hosted on the user's devices.


## Existing Propositions

> I want to review a lot more existing social media in order to pull inspiration. Here is a set that will be interesting to review:
> Mastodon, Matrix, Secure Scuttlebutt (SSB), Aether, Lemmy, Discord, Signal, Telegram, Slack, WhatsApp, Reddit, YouTube, Instagram, Facebook, Snapchat, TikTok, LinkedIn, Twitter/X, WeChat, Twitch, Medium, BeReal, Clubhluse

### Nebula

Nebula is a video-on-demand streaming service provider. Launched by the Standard Broadcast content management agency in 2019 to complement its creators' other distribution channels (primarily YouTube), the platform has since accumulated over 650,000 subscribers, making it the largest creator-owned internet streaming platform.<sup>[wikipedia](https://en.wikipedia.org/wiki/Nebula_(streaming_service))</sup>

#### Strong Points

- As it is creator-owned, they get to collectively decide on the functioning of the platform and ensures it follows the best interest of the members.
- The creators drive the development by having Nebula sponsoring their Youtube content. In turn the platform pays the creators for the watchtime they get on Nebula. This forms a positive feedback loop.
- They get huge benefits by negotiating group deals with sponsors, microphone brands, stock footage providers, sound editing software, branding designers, etc.
- Content moderation is ensured by selecting the creators that are part of the project which might be decided collectively.

#### Weaknesses

- The creators only own half of the platform and get a 50-50 deal and probably half of the decision making power.
- The creators generally come from a specific socioeconomic background and mostly from the US or the UK as it only is english speaking.
- Creators can hardly have dissenting stances to the collective. Second thought leaving the platform might be an example of this.
- The profitability of the company also is a constraint on creators political stances as the sponsors and partners could pressure Nebula.

# Dialogue

This document is a first attempt at defining the requirements of Dialogue, the social network of the future. It analyzes the benefits and limitations of existing social networks to build toward an extensive list of requirements.

## Core Principles

Some of these core principles might be idealistic, unreachable or vague but they serve as a north star. Every requirement and every feature has to be justified and can be debated relative to these principles.

Each principle correspond to a specific idea and should not overlap with others. The 1-2 are philosophical, 3-9 social, 10-14 technical and 15-18 methodological. Apart from these groupings, they are sorted in no particular order. The numbers are only there for referencing sake.

1. **Respectful**: Foster goodwill, empathy, openness and constructive communication.
2. **Progressive**: Foster optimistic visions and enable concrete actions toward humanity's collective future.
3. **Purposeful**: Encourage mindful and intentional technology use.
4. **Expressive**: Provide spaces for creative expression and knowledge sharing and embrace diverse voices and experiences.
5. **Collaborative**: Make working together on shared content as natural as working alone.
6. **Democratic**: Make collective and democratic organizing and decision-making more efficient than centralized systems.
7. **Empowering**: Entrust people with control over their digital environment and support them with appropriate tools.
8. **Accessible**: Ensure accessibility no matter the technical knowledge, the economical status, the cultural background, the physical disabilities, the language or the literacy.
9. **Attractive**: Has compelling reasons for people and communities to join, stay and grow with the platform enabling [network effects](https://en.wikipedia.org/wiki/Network_effect).
10. **Private**: Guarantee personal data sovereignty and communication confidentiality.
11. **Resilient**: Maintain platform availability even under state-level interdiction.
12. **Safe**: Ensure users can communicate without fear of identification or retribution even in repressive environments.
13. **Distributed**: Share computing and storage resources across devices to minimize environmental impact and ensure network independence.
14. **Modular**: Support community-driven development with a secure framework making every interface and algorithm customizable.
15. **Sustainable**: Ensure the platform's social and technical foundations remain viable and relevant across generational timescales.
16. **Empirical**: Rigorously justify, study and stress test every feature to ensure alignment with the *core principles*.
17. **Transparent**: Actively expose and explain all platform mechanisms, algorithmic systems, and community processes, enabling informed user participation and control.
18. **Governance**: Organize platform governance and development in a way that ensures consistent adherence to the *core principles*.

## Rationale

In this section we detail every principle, we explain what it is and isn't and we express the rationale behind each of them.

### 1. Respectful

Being respectful means fostering an environment where people feel safe to express themselves and engage with others constructively. This goes beyond basic politeness - it requires actively designing features that encourage empathy, understanding, and good faith communication.

This principle guides both the technical design (like prompting users to reconsider potentially harmful messages) and community norms (like emphasizing constructive feedback over negative reactions).

### 2. Progressive

Progress requires both vision and action. This principle ensures the platform actively supports positive change rather than just discussing it. It means providing tools for organizing initiatives, highlighting successful projects, and connecting people who want to build a better future.

This optimistic stance must be balanced with realism - the goal is to enable concrete steps forward, not just idealistic discussion.

### 3. Purposeful

Technology should serve human needs rather than creating addictive patterns. This principle guides us to design features that help people use the platform intentionally and productively.

This means avoiding dark patterns, engagement tricks, and infinite scrolling in favor of tools that help users achieve their goals efficiently.

### 4. Expressive

Providing spaces for expression means building the infrastructure people need to share their creativity and knowledge. This goes beyond just allowing content posting - it requires tools for different forms of expression, from text to multimedia.

Embracing diverse voices means actively considering different perspectives in the design process and ensuring the platform works well for people from all backgrounds.

### 5. Collaborative

Making collaboration as natural as working alone requires careful attention to user experience. Features must handle the complexity of group work while keeping interfaces simple and intuitive.

This enables both lightweight cooperation (like quick feedback on a draft) and complex projects (like maintaining shared documentation).

### 6. Democratic

Democratic organization means more than just voting - it requires tools for discussion, deliberation, and transparent decision-making. The platform must support various forms of governance while keeping processes clear and accessible.

This principle guides features like proposal systems, discussion tools, and voting mechanisms.

### 7. Empowering

Control over one's digital environment means having both the tools and the knowledge to use them effectively. This requires careful documentation, intuitive interfaces, and progressive disclosure of advanced features.

Users should understand what's happening with their data and have meaningful choices about how to manage it.

### 8. Accessible

Accessibility covers many dimensions - technical, economic, cultural, physical, linguistic, and educational. Each feature must be evaluated across all these aspects to ensure no one is unnecessarily excluded.

This often means providing multiple ways to accomplish tasks and careful attention to progressive enhancement.

### 9. Attractive

Network effects are crucial for social platforms - they become more valuable as more people join. This means designing features that give people compelling reasons to join, stay engaged, and bring their communities.

This must be balanced with other principles - growth should come from genuine value, not dark patterns or artificial virality.

### 10. Private

Privacy means giving users real control over their data and communications. This requires both technical measures (like encryption) and clear interfaces that help users understand and manage their privacy.

Defaults should protect privacy while making it easy to safely share when desired.

### 11. Resilient

Resilience means the platform keeps working even under adverse conditions - from network issues to active attempts at censorship. This requires careful distributed systems design and robust fallback mechanisms.

### 12. Safe

Safety requires protecting users from both technical and social threats. This means secure systems, clear community standards, and tools for managing unwanted contact or content.

This is especially crucial for users in repressive environments who need protection from surveillance and retaliation.

### 13. Distributed

Distribution of resources helps ensure both technical resilience and environmental sustainability. This means designing systems that efficiently share computing and storage loads across the network.

This principle guides both technical architecture and governance structures.

### 14. Modular

Modularity enables community-driven development while maintaining security. This requires careful API design and sandboxing to allow customization without compromising the platform's integrity.

This principle supports both technical extensibility and social adaptability.

### 15. Sustainable

Long-term sustainability requires attention to both technical and social foundations. This means choosing stable technologies, building maintainable systems, and creating governance structures that can evolve.

This principle helps evaluate every decision's long-term implications.

### 16. Empirical

Rigorous testing helps ensure features actually serve their intended purposes. This means gathering data (while respecting privacy), studying outcomes, and adjusting based on evidence.

This principle keeps development grounded in reality rather than assumptions.

### 17. Transparent

Transparency means users can understand how the platform works, from algorithms to governance. This requires clear documentation, open source code, and explicit explanation of automated systems.

This understanding enables meaningful user participation and control.

### 18. Governance

Consistent governance ensures the platform stays true to its principles over time. This requires clear processes for decision-making, conflict resolution, and adaptation to new challenges.

This principle guides both technical and community management structures.

## Requirements and Justifications

Here we propose a set of requirements that we justify in regards to the platform's core principles. We start every section with a wish list of features that would ideally be present. We then provide a list of possible solutions, their pros and cons.

### Platform's Name

The platform's name has to:

- Correspond to what it is: a social network
- Have a meaning that mirrors the platform's *core principles*
- Be readable and pronounceable in a large amount of languages (*accessible*)
- Be memorable (*attractive*)

#### Dialogue

- This is the current chosen name
- Pros:
  - Reflects the *respectful*, *expressive*, *collaborative* and *democratic* principles
  - Is easy to pronounce and has the same meaning in many languages
  - There is a clear social aspect making it sensible to label a social network
- Cons:
  - Probably won't get `dialogue.net`
  - SEO might be complicated

#### Inter Planetary Social Network (IPSN)

- Pros:
  - Reflects the *distributed*, *resilient*, *distributed* and *sustainable* principles
  - The fact that it is a social network is explicitly stated
  - Is enthusiastic about the future (*progressive*)
- Cons:
  - Quite long and difficult to pronounce for non english speakers
  - Its acronym isn't natural to read
  - Might be seen as piggy backing on the [IPFS](https://ipfs.tech/) ecosystem especially as it might not be built on top of it

### Programming Language

A programming language is an user interface as well as a model for thinking

- Easy to learn and master (*accessible*)
  - Great beginner resources
  - Serve as a great introduction to programming
  - Minimize the amount of core concepts
  - Easy to read and to express
    - This is successful when [syntactic sugar](https://en.wikipedia.org/wiki/Syntactic_sugar) becomes redundant
  - Single threaded code
  - Consistent interfaces across devices
- Easy to review and maintain (*sustainable*)
  - Enforces good practice through language design and compiler errors
  - Human readable and helpful compilation error messages
  - Compiler enforce good documentation practices
  - When it compiles it works except for mathematically untraceable issues
  - No implicit behavior
  - Strongly typed
  - Enables metaprograming for analysis and automated review
  - Compiler and tooling written in its own language
  - Has clear and uniform naming conventions
  - Standard formatting enforced by the compiler
  - Standard formatting avoids indentation pyramids
- Joins developer and designer's work
  - The code is the single source of truth
  - GUI enables designers to edit view code
- Built for distributed architecture (*distributed*)
  - [ORDT](http://archagon.net/blog/2018/03/24/data-laced-with-history/) as first class citizen
  - Enable distributed computations for heavy algorithms
- Run and compile on most devices with low network availability (*accessible*)
  - Parallelize program at compile time
  - Tiny bundle size
  - Be [local first](https://www.inkandswitch.com/local-first/)
  - Fast compilation
- Sandboxed (*modular*)
  - Functions have no side effects
  - A single datatype represents all possible side effects
    - It can be extended or shrunk based on the access we want to give to the sub program
- Can be translated in various languages (*accessible*)
- Has collaborative editing tools (*collaborative*)

#### Elm

[Elm](https://elm-lang.org/) is

#### Bend

[Bend](https://higherorderco.com/) seems great at compile time parallelization.

### Integrated Development Environment

We need a bunch of graphical tools for making the programming experience as smooth as possible

- Layout editor

The Elm architecture (time machine, ...).

### Identity verification

Online group decision-making often requires some level of identity verification to avoid [Sybil attacks](https://en.wikipedia.org/wiki/Sybil_attack).

#### The social graph of trust

One solution is to build a physical proof of personhood network where users meet in person and establish verified connections by scanning QR codes on each other's devices. This creates a social graph of trust that maintains privacy while making bot accounts detectable through network analysis.

Real human social networks tend to be densely interconnected, whereas bot accounts typically show suspicious patterns: few connections to verified humans, clustering through single gateway users, and unnatural network growth. While bad actors could attempt to verify bot accounts, their suspicious connection patterns would make them identifiable. The system becomes more robust as legitimate human connections accumulate, making it increasingly difficult to fake human-like network patterns at scale.

An organization can then use this network to validate identity. It could only consider votes entered by accounts with multiple trust connections to other members for instance.

-- Look at [web of trust](https://en.wikipedia.org/wiki/Web_of_trust).

## Success Metrics

Here we describe the metrics we will use to measure how well the platform follows each of its core principles.

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

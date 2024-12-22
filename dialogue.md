# Dialogue

This document is a first attempt at defining the requirements of Dialogue, a social network for the future of humanity. We states our goals and build toward an extensive list of requirements.

## Core Principles

Some of these core principles might be idealistic, unreachable or even a bit vague but they serve as a north star. Every requirement and every feature has to be justified and can be debated relative to these principles.

Each principle corresponds to a specific idea and are thought not to overlap with others. The principles 1-2 are philosophical, 3-7 social, 8-12 technical and 13-16 methodological. Apart from these groupings, they are sorted in no particular order. The numbers are only there for referencing sake.

1. **Respectful**: Foster goodwill, empathy, openness and constructive communication.
2. **Optimistic**: Build confidence in our collective ability to overcome current challenges and shape better futures through human ingenuity.
3. **Empowering**: Entrust people with control over their digital environment and support them with appropriate tools.
4. **Expressive**: Provide spaces for creative expression and knowledge sharing and embrace diverse voices and experiences.
5. **Democratic**: Make collective and democratic organizing and decision-making more efficient than centralized systems.
6. **Accessible**: Ensure accessibility no matter the technical knowledge, the economical status, the cultural background, the physical disabilities, the language or the literacy.
7. **Attractive**: Has compelling reasons for people and communities to join, stay and grow with the platform enabling [network effects](https://en.wikipedia.org/wiki/Network_effect).
8. **Private**: Guarantee personal data sovereignty and communication confidentiality.
9. **Resilient**: Maintain platform availability even under state-level interdiction.
10. **Safe**: Ensure users can communicate without fear of identification or retribution even in repressive environments.
11. **Distributed**: Share computing and storage resources across devices to minimize environmental impact and ensure network independence.
12. **Modular**: Support community-driven development with a secure framework making every interface and algorithm customizable.
13. **Sustainable**: Ensure the platform's social and technical foundations remain viable and relevant across generational timescales.
14. **Empirical**: Rigorously justify, study and stress test every feature to ensure alignment with the *core principles*.
15. **Transparent**: Actively expose and explain all platform mechanisms, algorithmic systems, and community processes, enabling informed user participation and control.
16. **Independent**: Organize platform governance and development in a way that ensures consistent adherence to the *core principles* and stay independent of states and corporations interests.

## Rationale

In this section we detail every principle, we express its underlying rationale, what it is, what it isn't and some practical implications.

### 1. Respectful

Divide and conquer is an infamous method of ruling and the individualism that is built in the heart of our society helps enormously with that task. Its easy to make people fight one an other based on whichever difference exist between them. We want to build bridges and have spaces for people to dialogue with one an other.

Being respectful means fostering an environment where people feel safe to express themselves and engage with others constructively. This goes beyond basic politeness - it requires actively designing systems that encourage empathy, mutual understanding, and good faith communication.

This doesn't mean avoiding hard or violent topics, nor does it mean abolishing debate or disagreement. It simply means to make ones best effort to reach the other, try to understand their point of view and progress from there.

This principle guides platform design through multiple channels: community guidelines and content creation tutorials can encourage empathetic communication, default platform metrics can track and highlight constructive interactions rather than inflammatory ones, default recommender systems can show diverse perspectives and default interface can prompt users to reconsider harmful messages before publishing. These mechanisms help shape a culture where seeking to understand others becomes as natural as expressing oneself.

### 2. Optimistic

In times of global challenges and systemic crises, it's easy to fall into doom scrolling and cynicism. This constant exposure to problems without solutions creates a paralyzing feedback loop: seeing no examples of positive change makes it harder to believe in or work toward solutions, which in turn means fewer positive examples for others.

Building confidence in our collective ability to overcome current challenges means breaking this cycle. This comes by sharing practical experiences and organizing to create new ones. When people see concrete examples of progress being made or being fought for, taking that first step toward engagement becomes possible.

This doesn't mean ignoring problems or promoting blind optimism. It simply means maintaining faith in human ingenuity and working towards concrete solutions. The platform should encourage content creators users stay informed about challenges while emphasizing where action can be taken and positive change happens or is being fought for.

This principle guides platform design through multiple channels: community guidelines and content creation tutorials can encourage solution-focused storytelling, default platform metrics can track and highlight constructive engagement rather than just reach, and default recommendation systems can be designed to balance problem awareness with solution-finding initiatives. These mechanisms help shape a culture where sharing progress and celebrating small wins becomes as natural as identifying challenges.

### 3. Empowering

Traditional platforms treat users as passive consumers of content and features, offering little control over their digital environment beyond superficial customization options. This creates learned helplessness where users accept whatever changes platforms impose, even when these changes work against their interests or needs. This problem is particularly visible in the [attention economy](https://en.wikipedia.org/wiki/Attention_economy) where corporations compete to grab users' attention at all costs, using invasive and addictive design practices with profound disregard for users' wants and needs.

Empowering means trusting users' capacity to make informed choices about their digital lives. This is about interface customization, recommendation algorithms, content filtering, interaction metrics, and information presentation. Users should understand how these systems affect their behavior and have meaningful ways to adjust or replace them to align with their own purposes and values.

This isn't about overwhelming users with technical complexity, nor about removing helpful defaults or making the platform less engaging. Rather, it's about respecting users' autonomy and supporting their growth from passive consumers to active participants who understand and control their digital environment. The platform should make visible the mechanisms that guide behavior and provide tools to modify them according to personal values and goals.

This principle guides platform design through: transparent algorithms that users can understand and modify, usage dashboards that help users self-reflect, customizable metrics that align with personal values rather than engagement maximization, and settings to modify or disable potentially addictive features. These mechanisms help users reclaim agency over their online experience and maintain a healthy relationship with technology.

### 4. Expressive

The world wide web brought an unprecedented ability for people to share ideas and knowledge across the world but - as the [platform economy](https://en.wikipedia.org/wiki/Platform_economy) grew - private corporations took control over our means of communication and entertainment. These platforms not only amplify already-popular voices while making it increasingly difficult for new or niche creators to reach and grow their audience, creating a self-reinforcing cycle of visibility inequality, but they also readily comply with state censorship demands, further limiting the diversity of voices and ideas that can be expressed online.

To follow the expressive principle means to provide diverse peoples ways to express, publish, share and sustain creative work. It includes hosting dissident voices. This involves supporting creators, making tools and resources that help them initiate their creative work, find their core audience and open multiple paths to sustainable content creation.

This isn't about limiting successful creators or forcing equality of outcomes. Rather, it means ensuring that success comes from genuine audience connection and content quality rather than algorithmic bias. The goal is to create multiple viable paths to sustainable content creation, where both niche creators serving specific communities and broadly popular voices can thrive.

In practice this comes down to handling various content formats (from text articles to long-form video passing by digital comics), having discovery pages for each of them recommending content based on a variety of metrics and algorithms. To make content production sustainable the platform may integrate crowd funding systems and a page to connect creators and advertisers.

### 5. Democratic

Traditional social platforms tend to concentrate power in the hands of platform owners and their algorithms, leaving users and communities with little say in how their spaces are governed. Even when platforms offer community moderation tools, these are often limited and can be overridden by corporate decisions driven by profit motives rather than community needs.

Democratic organization means creating spaces where communities can effectively self-govern and make collective decisions. This requires not just voting mechanisms, but comprehensive tools for discussion, investigation, deliberation, consensus-building, and transparent decision-making. The platform must support various forms of democratic governance - from direct democracy to representative systems - while keeping processes clear and accessible to all participants.

This isn't about forcing every group to use the same democratic model. Rather, it's about making democratic organization more efficient and accessible than centralized control. Communities should be able to choose and evolve their governance structures while maintaining transparency and accountability to their members.

This principle guides platform design through multiple channels: built-in tools for proposals and voting, structured discussion spaces for investigation and deliberation, transparent record-keeping of decisions and their rationales, and flexible permission systems that communities can adapt to their needs. These mechanisms help make collective decision-making as natural and efficient as individual action.

### 6. Accessible

Large segments of the population are excluded of the online discourse through various barriers: expensive devices or data plans, complex interfaces that assume technical literacy, designs that don't work with assistive technologies, content available only in majority languages, poor internet access or non [net neutral](https://en.wikipedia.org/wiki/Net_neutrality) internet providers. This creates digital divides that reinforce existing social inequalities and limit the internet's potential for inclusive dialogue and collective action.

Making a social platform truly accessible means considering every feature through multiple lenses:

- Technical: Works on low-end devices and slow/intermittent connections
- Economic: Free to use with minimal hardware requirements
- Cultural: Respects and accommodates different cultural norms and practices
- Physical: Compatible with assistive technologies and follows accessibility standards
- Linguistic: Available in multiple languages with clear paths for community translation
- Educational: Usable regardless of technical literacy or formal education level

This isn't about dumbing down features or limiting capabilities. Rather, it's about thoughtful development thinking every functionality from the start to be nice to use for everyone.

This principle guides platform design through multiple channels: responsive interfaces that work across device types, offline-first architecture that handles poor connectivity, built-in translation tools, context-sensitive help systems, and careful attention to accessibility standards. These mechanisms ensure that no one is excluded from participating in the platform's community.

### 7. Attractive

One of the internet's greatest achievements has been helping people maintain meaningful connections across time and distance - old friends finding each other again and families staying close despite living continents apart. But this only works when people can actually find each other. A social network needs to attract and retain enough users to make these connections possible, otherwise even the best features become meaningless in an empty space.

Being attractive means designing features and mechanisms that give people genuine reasons to join and stay on the platform. This requires both understanding what brings real value to users' lives - whether that's reconnecting with old friends, finding communities that share their interests, or discovering new perspectives - and creating sustainable growth mechanisms that benefit both users and creators. The platform should grow through authentic utility, meaningful interactions, and positive feedback loops that align everyone's interests.

This isn't about using dark patterns, artificial virality, or manipulative engagement tactics to drive growth. Rather, it's about creating genuine value that makes people want to join and stay. The platform should grow through word-of-mouth and demonstrated utility, not through exploiting psychological vulnerabilities or creating artificial urgency.

Building trust through genuine collaboration with creators and users is key to enable the best advertisement there is: word of mouth. In order to get there we need to support creators and users success through community building tools and sustainable revenue models, and to foster a co-building relationship where their feedback shapes the platform's evolution. To reach new user bases platform-funded and crowdfunded exclusive content can attract new audiences and creators can introduce their communities to the platform through cross-platform content strategies.

### 8. Private

Traditional social platforms treat user data as a commodity to be exploited - selling it to advertisers, training AI models without consent, sharing it with third parties, and readily handing it over to state surveillance. This creates a situation where every interaction, every connection, and every piece of content becomes potential leverage against users, whether for commercial manipulation or state control. Even "private" messages and closed groups are ultimately accessible to platform owners and their partners.

Privacy means giving users genuine control over their data and communications. This extends beyond basic settings to fundamental control over where data is stored, who can access it, and how it's used. Users should understand what data they're generating, have meaningful choices about its storage and sharing, and trust that their private communications remain truly private through strong encryption and transparent security measures.

This isn't about making all content completely private or preventing any form of sharing. Rather, it's about ensuring users have real control and understanding of their privacy choices. The platform should make it easy to share safely when desired while maintaining strong privacy by default and protecting users from accidental exposure.

Strong encryption protects all communications by default, clear interfaces help users understand and control their privacy settings, they get to decide where to store their data, transparent documentation explains how data is stored and processed and granular sharing controls let users decide exactly what to share with whom. These mechanisms ensure users maintain genuine sovereignty over their data while making safe sharing straightforward when desired.

### 9. Resilient

Resilience means the platform keeps working even under adverse conditions - from network issues to active attempts at censorship. This requires careful distributed systems design and robust fallback mechanisms.

### 10. Safe

Safety requires protecting users from both technical and social threats. This means secure systems, clear community standards, and tools for managing unwanted contact or content.

This is especially crucial for users in repressive environments who need protection from surveillance and retaliation.

### 11. Distributed

Distribution of resources helps ensure both technical resilience and environmental sustainability. This means designing systems that efficiently share computing and storage loads across the network.

This principle guides both technical architecture and governance structures.

### 12. Modular

No platform is neutral. Its design constrains what gets expressed and its algorithms serves as an editorial line. Every medium has implicitly or explicitly stated goals and philosophies. We stated those in the *respectful*, *optimistic*, *purposeful* and *democratic* principles. As much as the dev team strives for those goals we also do not believe they will always get it right nor adapted to every single specific case.

Modularity enables community-driven development while maintaining security. This requires careful API design and sandboxing to allow customization without compromising the platform's integrity.

This principle supports both technical extensibility and social adaptability.

### 13. Sustainable

Long-term sustainability requires attention to both technical and social foundations. This means choosing stable technologies, building maintainable systems, and creating governance structures that can evolve.

This principle helps evaluate every decision's long-term implications.

### 14. Empirical

Rigorous testing helps ensure features actually serve their intended purposes. This means gathering data (while respecting privacy), studying outcomes, and adjusting based on evidence.

This principle keeps development grounded in reality rather than assumptions.

### 15. Transparent

Transparency means users can understand how the platform works, from algorithms to governance. This requires clear documentation, open source code, and explicit explanation of automated systems.

This understanding enables meaningful user participation and control.

### 16. Independence

Consistent governance ensures the platform stays true to its principles over time. This requires clear processes for decision-making, conflict resolution, and adaptation to new challenges.

This principle guides both technical and community management structures.

The dev team are the initiators of the platform's culture. They have to be the prime examples of its principles and their behavior towards the rest of the community has to reflect that.

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

## Notes

Various notes and precisions about this document.

### On our use of LLMs

Parts of this document have been written in cooperation with a LLM and similar tools will likely be used to implement the platform.

We recognize the way these algorithms have been trained in problematic ways using data without author's acknowledgement and poorly paid labor for data labeling. Though we also believe LLMs are useful tools that can be used for human emancipation. A hammer can break a skull but it mey also serve to build bridges, houses and hospitals. In other words, deleterious conditions that produced that hammer may be changed with the help of that very hammer. This reasoning works as much for LLMs as for textile factories and mining industries.

In terms of content originality, we do not attempt to be especially original or novel. Our main aim is to express ideas and develop techniques to bring them to life. No matter who or what expresses those ideas as long as they match our thoughts and needs.

We have made the writing process transparent by sharing the dialogue's history. It can be found in the `.aider.chat.history.md` file.

## Legacy and wip Text

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

## Notes

Various notes and precisions about this document.

### About interoperability

interoperable but in very specific ways /
transparent also means interoperable /
evergreen design architecture /
possible breaking changes /
useful for attractive /
but might break secure, safe and/or private /
keep control within Dialogue /
might be needed for governance

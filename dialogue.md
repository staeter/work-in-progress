# Dialogue

Dialogue is a tool for people to constructively discuss, debate and organize despite bad actors trying to cause descent and state level repression. It defends freedom of speech while creating safe spaces for people to group together.

## Encourage Pro-Social Behavior

The platform should favor as much as possible thoughtful and constructive behavior.
It is extremely easy to spread short and misinformed messaging. To counter it we usually need a lot of moderation, but as we want to keep the data under user's control we need users to make their own content moderation. Dialogue has to provide tooling to make this task as easy and accessible as possible so that it becomes a place that fosters fulfilling interactions.

**Principles**:

- The platform encourages users to be empathic with one an other.
- The platform pushes the users to take responsibility over their experience.
- Good behavior has to be nudged instead of forcibly imposed.
- The platform provides tooling for content moderation to be handled collectively by the users.

**Design Ideas**:

- Detect aggressive or hurtful writing in a post or comment and prompt the user to think about the people that message might hurt before posting it online.
- Users can setup custom content flagging systems and share their flags with one an other.
- Users can code their own recommender systems.

## Tools to Organize

Many tasks inside and outside the platform need users to organize with one an other.

**Principles**:

- Users can make organizations and set rules for their functioning.
- Various debate and messaging systems are provided and encourage constructive dialogue.
- Decision making methods are extremely modular and can go from a single person deciding everything to any convoluted voting, electing and revoking systems.
- Any organization can provide a specific content moderation for other users to use.
- The platform provides tooling for collaborative editing of documents.

## Accessible

This software is aimed at the largest audience possible.

**Principles**:

- The technical and cultural barrier to access and use the app must be as low as possible.
- The interfaces should be [accessible](https://en.wikipedia.org/wiki/Computer_accessibility) to people with disabilities.

## International

People from any country and cultural environment should be able to use the platform and to potentially communicate and organize with anyone else on the platform.

**Principles**:

- People should be able to communicate and organize across linguistic and national barriers.
- The design of the interface must be adaptable for various cultural and linguistic environments.

**Implementation Ideas**:

- Different versions of the interface can be provided as extensions.
- Translation algorithms can be provided as extensions and hosted on the user's devices.

## Data Privacy

User's privacy has to be guaranteed.

**Principles**:

- Data has to be fully encrypted and under user's informed control.
- Defaults always protects user's privacy.
- Users have control over where they store their data.

## Local First and Fully Distributed

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

## Payment System

A payment solution has to be provided as many services required for the platform to function need money to be exchanged.

> Some of the principles below are mathematically impossible. They are quite naive and need more precision.

**Principles**:

- Secure and reliable.
- Anonymous and untraceable.
- Keeps working under heavy network partitioning.
- Byzantine resistant.

**Useful Inspirations**:

- [filecoin](https://filecoin.io/) as a cooperative storage cloud with a reward model, it also doubles as a crypto currency.

## Easy to Customize

Essentially everything in Dialogue has to be customizable for it to match all of its constraints.

**Principles**:

- The programming language used for extensions has to be easy to learn, debug and maintain.
- GUI are provided where possible.
- APIs accessed by extensions must be constrained enough to make code injection or the use of any other hacking methods impossible.

**Useful Inspirations**:

- [Elm](https://elm-lang.org/)

## Hard to Track

The software should withstand state level interdiction and make its users as innocuous as possible.

> This would be ideal but I'm out of my technical depth here.

**Principles**:

- The network communications made between clients have to be innocuous and untraceable.
- It should be possible to make the app hardly recognizable by any other software on the device.

**Useful Inspirations**:

- [Metamorphic code](https://en.wikipedia.org/wiki/Metamorphic_code) can be used to make the app unrecognizable.

## Development Financing

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

## Existing Propositions

> I want to review a lot more existing social media in order to pull inspiration. Here is a set that will be interesting to review:
>

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

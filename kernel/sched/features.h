/*
 * Only give sleepers 50% of their service deficit. This allows
 * them to run sooner, but does not allow tons of sleepers to
 * rip the spread apart.
 */
SCHED_FEAT(GENTLE_FAIR_SLEEPERS, false)

/*
 * Place new tasks ahead so that they do not starve already running
 * tasks
 */
SCHED_FEAT(START_DEBIT, true)

/*
 * Prefer to schedule the task we woke last (assuming it failed
 * wakeup-preemption), since its likely going to consume data we
 * touched, increases cache locality.
 */
SCHED_FEAT(NEXT_BUDDY, true)

/*
 * Prefer to schedule the task that ran last (when we did
 * wake-preempt) as that likely will touch the same data, increases
 * cache locality.
 */
SCHED_FEAT(LAST_BUDDY, true)

/*
 * Consider buddies to be cache hot, decreases the likelyness of a
 * cache buddy being migrated away, increases cache locality.
 */
SCHED_FEAT(CACHE_HOT_BUDDY, true)

/*
 * Allow wakeup-time preemption of the current task:
 */
SCHED_FEAT(WAKEUP_PREEMPTION, true)

/*
 * Use arch dependent cpu power functions
 */
SCHED_FEAT(ARCH_POWER, true)

SCHED_FEAT(HRTICK, false)
SCHED_FEAT(DOUBLE_TICK, false)
SCHED_FEAT(LB_BIAS, true)

/*
 * Decrement CPU power based on time not spent running tasks
 */
SCHED_FEAT(NONTASK_POWER, true)

/*
 * Queue remote wakeups on the target CPU and process them
 * using the scheduler IPI. Reduces rq->lock contention/bounces.
 */
SCHED_FEAT(TTWU_QUEUE, true)

SCHED_FEAT(FORCE_SD_OVERLAP, false)
SCHED_FEAT(RT_RUNTIME_SHARE, false)
SCHED_FEAT(LB_MIN, false)

/*
 * Apply the automatic NUMA scheduling policy. Enabled automatically
 * at runtime if running on a NUMA machine. Can be controlled via
 * numa_balancing=. Allow PTE scanning to be forced on UMA machines
 * for debugging the core machinery.
 */
#ifdef CONFIG_NUMA_BALANCING
SCHED_FEAT(NUMA,	false)
SCHED_FEAT(NUMA_FORCE,	false)
#endif

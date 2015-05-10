# ILED: Incremental Learning Event Definitions


ILED is an incremental Inductive Logic Programming system. It has been designed for scalable learning of logical theories from large amounts of sequential data with a time-like structure. ILED has been designed having in mind the construction of knowledge for event recognition applications, but it can practically be used within any domain where ILP is applicable. It is based on Abductive-Inductive Logic Programming and it is implemented in Python 2.7, using an ASP solver (Clingo) as the main reasoning Component. Please consult the following papers to get a grasp on the theory behind ILED:

[ILED's technical report](http://arxiv.org/pdf/1402.5988v2.pdf)


O. Ray. Nonmonotonic Abductive Inductive Learning. Journal of Applied Logic 7(3): 329-340, 2009.


For information on Answer Set Programming (ASP) and the input language of ILED, please consult the material from the [Potsdam Answer Set Solving Team](http://potassco.sourceforge.net/).

## Licence

This program comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under certain conditions; See the GNU General Public License v3 for more details.

## Using ILED (batch mode)

To use ILED you need to provide the following with the input:

1) Some background knowledge in ASP format. To do so, edit the `/knowledge/bk.lp` file with your own input.

2) A set of mode declarations. To do so, edit the `/knowledge/modes.pl` file with your own input. Mode declarations are a widely used language bias in ILP, specifying the syntax of target rules. For more information, please consult the reference papers mentioned above.

3) A set of training examples. To do so, edit the `/knowledge/examples.pl`. Examples must be provided in the form of ground atoms, wrapped inside an `example` predicate. For instance

`
example(father(john,peter)).
`

You also need to specify the target predicate(s) pattern. These are typically some (or) all of your head mode declarations. To do so, edit the `example_patterns` field in `/src/core.py`, take a look in that file to see some examples. 

Once you have prepared the input, you run the system by running the /src/main.py script. This is a simple way to use ILED in "batch" mode, i.e. by providing all examples at once and trying to learn a hypothesis. However, ILED has been designed for scalable learning from large volumes of data, in cases where processing all data at once is intractable, or where data arrive over time. It thus operates also in an incremental mode, constructing a hypothesis from the first available piece of data, and revising it as long as new data arrives, while revisions account for the whole set of accumulated expirience. To implement this functionality, ILED relies on an external database (mongodb) the serves as a historical memory. So you can set up your data storage in a mongodb instance and run ILED to learn incrementally.

## Using ILED (incremental mode)

The best way to see how this works is to run ILED on the data provided here. ILED has been evaluated on two large-scale event recognition applications: Activity Recognition and City Transport Management. For both these domains, data and necessary knowledge (background knowledge and mode declarations) are provided. 

#### City Transport Management (CTM)

The CTM dataset was created in the context of the [PRONTO project](http://www.ict-pronto.org/). For information of this dataset, please consult [ILED's technical report](http://arxiv.org/pdf/1402.5988v2.pdf). You can download the dataset, along with information on how to set-up mongodb, import the data from the provided JSON dumps and run ILED from [this link](http://users.iit.demokritos.gr/~nkatz/ILED-data/)

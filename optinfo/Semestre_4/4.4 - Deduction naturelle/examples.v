Variables P Q R : Prop.

Theorem modus_tollens : (P -> Q) -> (~Q -> ~P).
Proof.
  intros HPiQ HnQ.

  unfold not. (* P -> False *)

  intro HP.     (* P *)

  apply HPiQ in HP. (* utilisation de l'implication *)

  contradiction.
Qed.

Theorem modus_ponens : (P -> Q) -> P -> Q.
Proof.
intros HPiQ HP.

apply HPiQ.

apply HP.
Qed.

Theorem syllogisme_hypothetique: (P->Q) -> (Q -> R) -> (P->R).
Proof.
intros HPiQ HQiR.

intros HP.

apply HPiQ in HP.

apply HQiR in HP.

assumption.
Qed.

Theorem verimp: (~P \/ Q) -> (P -> Q).
Proof.

intros HnPoQ HP.

destruct HnPoQ as [HnP|HQ].

- unfold not in HnP.
  apply HnP in HP.
  contradiction. (* ex falso quod libet *)

- assumption.

Qed.

Theorem contradict : forall (A B : Prop), A /\ ~A -> B.
Proof.

  intros A B HAanA.
  
  destruct HAanA as [HA HnA].
  
  contradiction. (* ex falso quod libet *)
Qed.

Theorem deMorgan :  ~(P \/ Q) -> ~P /\ ~Q.
Proof.
  intros H.

  split. (* division de l'objectif non P et non Q *)

  (* Prouver ~P *)
  - 
    intros HP.
    apply H. (* ou P Q doit alors \u00eatre vrai *)
    left. (* il suffit que la partie gauche de P  \/ Q soit vraie *)
    exact HP. (* regarde, l'objectif est l\u00e0 dans les hypoth\u00e8ses *)

  (* Prouver ~Q *)
  - 
    intros HQ.
    apply H.  (* ou P Q doit alors \u00eatre vrai *)
    right. (* il suffit que la partie droite de P \/ Q  soit vraie *)
    exact HQ. (* regarde, l'objectif est l\u00e0 dans les hypoth\u00e8ses *)
Qed.